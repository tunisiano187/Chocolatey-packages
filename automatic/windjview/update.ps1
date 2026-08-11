import-module chocolatey-AU
. ..\..\scripts\Get-FileVersion.ps1

# Use the SourceForge RSS feed scoped to /WinDjView so any future version folder
# (e.g. 2.2, 3.0) is discovered automatically instead of being hardcoded.
# Investigated 2026-06-09: upstream is still on v2.1 with no newer release.
$releases = 'https://sourceforge.net/projects/windjview/rss?path=/WinDjView'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[xml]$rss = (Invoke-WebRequest -Uri $releases -UseBasicParsing).Content
	$item = $rss.rss.channel.item |
		Where-Object { $_.link -like '*-Setup.exe/download*' } |
		Select-Object -First 1
	if (-not $item) { throw 'No WinDjView Setup installer found in RSS feed' }

	$url32   = $item.link
	$version = [regex]::Match($url32, 'WinDjView-(\d+(?:\.\d+)+)-Setup\.exe').Groups[1].Value
	if (-not $version) { throw "Could not parse version from URL: $url32" }

	# Use Get-FileVersion (Invoke-WebRequest) to follow the SourceForge /download
	# redirect and compute the checksum. WebClient.DownloadFile (used by both
	# Get-RemoteChecksum and AU's -ChecksumFor) treats the trailing /download path
	# segment as a nested directory, causing a DirectoryNotFoundException.
	$fileVersion = Get-FileVersion $url32

	# Detect silent binary replacements: if the remote checksum differs from the
	# value already stored in chocolateyInstall.ps1, bump with a datestamp so AU
	# publishes the corrected binary even when the upstream version string is unchanged.
	$installContent   = Get-Content "$PSScriptRoot\tools\chocolateyInstall.ps1" -Raw
	$current_checksum = [regex]::Match($installContent, "\`$checksum\s*=\s*'([a-fA-F0-9]{64})'").Groups[1].Value
	if ($current_checksum.Length -eq 64 -and $current_checksum -ne $fileVersion.Checksum) {
		$version = "$version.$(Get-Date -Format 'yyyyMMdd')"
	}

	return @{
		URL32          = $url32
		Version        = $version
		Checksum32     = $fileVersion.Checksum
		ChecksumType32 = $fileVersion.ChecksumType
	}
}

update -ChecksumFor none -NoCheckChocoVersion
