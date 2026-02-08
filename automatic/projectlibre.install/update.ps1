import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'http://sourceforge.net/projects/projectlibre/files/latest/download'

function global:au_SearchReplace {
	@{
		".\tools\VERIFICATION.txt" = @{
			"(?i)(\s+x32:).*"                   = "`${1} $($Latest.URL32)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL32)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum32)"
		  }
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
	Invoke-WebRequest -Uri "https://www.projectlibre.com/license/" -OutFile .\tools\LICENSE.txt
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
	$url32 = ($response.Links | Where-Object {$_.href -match '\.exe'} | Select-Object -First 1).href
	if (-not $url32) {
		throw "Could not find .exe download link"
	}
	$version = $url32.Split('/')[-2]

	$url32 = Get-RedirectedUrl "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/projectlibre-$version.exe/download"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
