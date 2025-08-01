import-module chocolatey-AU

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
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href | Select-Object -First 1
	$version = $url32.Split('/')[-2]

	$url32 = Get-RedirectedUrl "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/projectlibre-$version.exe/download"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
