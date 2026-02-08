import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'http://sourceforge.net/projects/projectlibre/files/latest/download'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$response = Invoke-WebRequest -Uri $releases -UseBasicParsing
	if (-not $response.Links) {
		throw "No download links found on $releases"
	}
	$url32 = ($response.Links | Where-Object {$_.href -match '\.zip'} | Select-Object -First 1).href
	if (-not $url32) {
		throw "Could not find .zip download link"
	}
	$version = $url32.Split('/')[-2]

	$url32 = Get-RedirectedUrl "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/projectlibre-$version.zip/download"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
