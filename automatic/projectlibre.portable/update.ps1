import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
. ..\..\scripts\Get-FileVersion.ps1

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
	# SourceForge latest/download redirects to the JAR file URL which contains the version
	$redirectUrl = Get-RedirectedUrl 'https://sourceforge.net/projects/projectlibre/files/latest/download'
	if (-not $redirectUrl) {
		throw "Could not follow SourceForge redirect"
	}

	# Extract version from URL like: .../ProjectLibre/1.9.8/projectlibre-1.9.8.jar
	$versionMatch = $redirectUrl | Select-String -Pattern '/ProjectLibre/([\d.]+)/'
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from redirect URL: $redirectUrl"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	# Keep the permanent SourceForge /download URL — do NOT call Get-RedirectedUrl here.
	# Get-RedirectedUrl returns CDN mirror URLs with query params (?viasf=1, ?ts=...&use_mirror=...)
	# that WebClient.DownloadFile treats as illegal path characters, breaking AU's checksum
	# logic. Get-FileVersion uses Invoke-WebRequest which follows the redirect transparently.
	$url32 = "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/projectlibre-$version.zip/download"

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
