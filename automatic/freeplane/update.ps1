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
	# SourceForge's "direct download" URLs end in a trailing "/download" segment (e.g.
	# .../Freeplane-Setup-1.13.3.exe/download) -- that trailing segment is not part of the real file
	# name, so it has to be stripped before taking the last path segment, otherwise the derived name
	# is just the literal word "download".
	$fileName = ($Latest.URL32 -replace '/download$', '').Split('/')[-1]
	if (-not $fileName) { $fileName = "freeplane-$($Latest.Version).exe" }
	$destPath = Join-Path $env:TEMP $fileName

	# SourceForge's automatic mirror selection (the plain "/download" URL) is unreliable from CI /
	# datacenter IPs: instead of a redirect to a real binary it can serve a small HTML "choose a
	# mirror" / bot-block page that still downloads instantly and has a non-zero size (this is why
	# the download here completed in under a second for a 150+ MB installer). It's consistently
	# reliable from residential/office IPs, which is why this doesn't reproduce locally. Retry
	# against a couple of explicitly pinned mirrors (?use_mirror=...) before giving up -- the file
	# content, and therefore its checksum, is identical regardless of which mirror serves it.
	$downloadUrls = @($Latest.URL32) + @('netcologne', 'deac-riga', 'excellmedia') | ForEach-Object {
		if ($_ -eq $Latest.URL32) { $_ } else { "$($Latest.URL32)?use_mirror=$_" }
	}

	$validExe = $false
	foreach ($attemptUrl in $downloadUrls) {
		try {
			Invoke-WebRequest -Uri $attemptUrl -OutFile $destPath -UseBasicParsing -ErrorAction Stop
		} catch {
			continue
		}
		if (-not (Test-Path $destPath) -or (Get-Item $destPath).Length -eq 0) { continue }
		# A non-empty file isn't proof of a valid installer (see comment above). Confirm it's
		# actually a Windows PE executable by checking for the 'MZ' DOS header magic bytes -- if
		# this passes, the checksum baked into chocolateyInstall.ps1 is guaranteed to correspond to
		# a real installer, and Chocolatey's own -Checksum verification at install time protects
		# against the URL serving something different later.
		$header = [byte[]]::new(2)
		$stream = [System.IO.File]::OpenRead($destPath)
		try { $stream.Read($header, 0, 2) | Out-Null } finally { $stream.Close() }
		if ($header[0] -eq 0x4D -and $header[1] -eq 0x5A) { $validExe = $true; break }
	}
	if (-not $validExe) {
		throw "Downloaded file is not a valid Windows executable (missing 'MZ' header) after trying the default URL and fallback mirrors: $destPath (from $($Latest.URL32))"
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
