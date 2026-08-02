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
	# Clean up any old installer files before downloading the new one
	Get-ChildItem "tools\*.exe" -ErrorAction SilentlyContinue | Remove-Item -Force
	# SourceForge URLs end with /download; extract the .exe filename from the second-to-last path segment
	$urlSegments = ([uri]$Latest.URL32).AbsolutePath -split '/' | Where-Object { $_ }
	$cleanFileName = if ($urlSegments[-1] -eq 'download') {
		[uri]::UnescapeDataString($urlSegments[-2])
	} else {
		[System.IO.Path]::GetFileName(([uri]$Latest.URL32).LocalPath)
	}
	$destPath = "tools\$cleanFileName"
	Invoke-WebRequest -Uri $Latest.URL32 -OutFile $destPath -UseBasicParsing
	if (-not (Test-Path $destPath) -or (Get-Item $destPath).Length -eq 0) {
		throw "Installer download failed or produced an empty file: $destPath (from $($Latest.URL32))"
	}
	# A non-empty file isn't proof of a valid installer: SourceForge occasionally serves a small
	# HTML page (bot-block / mirror-choice interstitial) instead of the binary, which still has a
	# non-zero size and would previously slip through here, get pushed, and fail Chocolatey
	# verification with no exe found. Confirm it's actually a Windows PE executable by checking
	# for the 'MZ' DOS header magic bytes.
	$header = [byte[]]::new(2)
	$stream = [System.IO.File]::OpenRead($destPath)
	try { $stream.Read($header, 0, 2) | Out-Null } finally { $stream.Close() }
	if ($header[0] -ne 0x4D -or $header[1] -ne 0x5A) {
		throw "Downloaded file is not a valid Windows executable (missing 'MZ' header): $destPath (from $($Latest.URL32))"
	}
	$Latest.Checksum32 = (Get-FileHash -Path $destPath -Algorithm SHA512).Hash
	$Latest.ChecksumType32 = 'sha512'
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
