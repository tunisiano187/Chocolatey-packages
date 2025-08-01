$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://keepass.info/plugins.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = "https://keepass.info/$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "OtpKeyProv-"} | Where-Object {$_.href -notmatch '-source'}).href)"
	$version = $url32.split('-')[-1].Replace('.zip','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
