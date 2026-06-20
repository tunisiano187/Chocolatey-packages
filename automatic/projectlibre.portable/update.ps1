import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
. ..\..\scripts\Get-FileVersion.ps1

$releases = 'https://sourceforge.net/projects/projectlibre/rss?path=/ProjectLibre'

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
	[xml]$rss = Invoke-WebRequest -Uri $releases -UseBasicParsing | Select-Object -ExpandProperty Content
	$item = $rss.rss.channel.item | Where-Object {
		$_.link -match 'projectlibre-[\d.]+\.zip/download'
	} | Select-Object -First 1

	if (-not $item) {
		throw "Could not find zip download entry in SourceForge RSS feed"
	}

	$url32 = $item.link
	$versionMatch = [regex]::Match($url32, 'projectlibre-([\d.]+)\.zip')
	if (-not $versionMatch.Success) {
		throw "Could not extract version from RSS link: $url32"
	}
	$version = $versionMatch.Groups[1].Value

	# Keep the permanent SourceForge /download URL — do NOT call Get-RedirectedUrl here.
	# Get-FileVersion uses Invoke-WebRequest which follows the redirect transparently.
	$FileVersion = Get-FileVersion $url32
	$Latest = @{
		URL32          = $url32
		Version        = $version
		Checksum32     = $FileVersion.Checksum
		ChecksumType32 = $FileVersion.ChecksumType
	}
	return $Latest
}

update -ChecksumFor none
