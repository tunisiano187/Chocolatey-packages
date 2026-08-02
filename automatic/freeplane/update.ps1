$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://sourceforge.net/projects/freeplane/rss?path=/freeplane%20stable'

function global:au_SearchReplace {
	@{
		'.\legal\VERIFICATION.txt' = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		}
		'tools\chocolateyInstall.ps1' = @{
			"(^\s*[$]url\s*=\s*)('.*')"           = "`$1'$($Latest.URL32)'"
			"(^\s*[$]checksum\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum32)'"
			"(^\s*[$]checksumType\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	# Update license from the current stable branch
	$version = $Latest.Version
	$majorMinor = ($version -split '\.')[0..1] -join '.'
	$licenseBranch = "$majorMinor.x"
	try {
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/$licenseBranch/license.txt" -OutFile "legal\LICENSE.txt" -UseBasicParsing -ErrorAction Stop
	} catch {
		# Fall back to 1.12.x if the branch-specific URL fails
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/freeplane/freeplane/1.12.x/license.txt" -OutFile "legal\LICENSE.txt" -UseBasicParsing
	}
	# The installer is no longer embedded in the package (see #4298/#4312 history): chocolateyInstall.ps1
	# now downloads it fresh at install time via -Url/-Checksum, so the packaging step can no longer lose
	# a bundled file. We still need to download it here once, to a scratch location outside the package
	# directory, purely to compute a checksum for chocolateyInstall.ps1's -Checksum parameter.
	$destPath = Join-Path $env:TEMP "freeplane-$($Latest.Version).exe"
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $destPath -UseBasicParsing
	if (-not (Test-Path $destPath) -or (Get-Item $destPath).Length -eq 0) {
		throw "Installer download failed or produced an empty file: $destPath (from $($Latest.URL32))"
	}
	# A non-empty file isn't proof of a valid installer: SourceForge occasionally serves a small
	# HTML page (bot-block / mirror-choice interstitial) instead of the binary, which still has a
	# non-zero size. Confirm it's actually a Windows PE executable by checking for the 'MZ' DOS
	# header magic bytes -- if this passes, the checksum baked into chocolateyInstall.ps1 is
	# guaranteed to correspond to a real installer, and Chocolatey's own -Checksum verification at
	# install time protects against the URL serving something different later.
	$header = [byte[]]::new(2)
	$stream = [System.IO.File]::OpenRead($destPath)
	try { $stream.Read($header, 0, 2) | Out-Null } finally { $stream.Close() }
	if ($header[0] -ne 0x4D -or $header[1] -ne 0x5A) {
		throw "Downloaded file is not a valid Windows executable (missing 'MZ' header): $destPath (from $($Latest.URL32))"
	}
	$Latest.Checksum32 = (Get-FileHash -Path $destPath -Algorithm SHA512).Hash
	$Latest.ChecksumType32 = 'sha512'
	Remove-Item -Path $destPath -Force -ErrorAction SilentlyContinue
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$rss = Invoke-WebRequest -Uri $releases | Select-Object -ExpandProperty Content
	# Select the standard (non-touchscreen, non-archive) Setup .exe
	$items = $rss.rss.channel.item | Where-Object {
		($_.link -like "*Freeplane-Setup-[0-9]*.exe/download*") -and
		($_.link -notlike "*/archive/*") -and
		($_.link -notlike "*touchscreen*")
	} | Select-Object -First 1

	$url32 = $items.link
	$versionMatch = [regex]::Match($url32, 'Freeplane-Setup-(\d+\.\d+(?:\.\d+)?(?:-u\d+)?)\.exe')
	$version = $versionMatch.Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
