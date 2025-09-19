$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://minepi.com/pi-blockchain/pi-node/'

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
	$url = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".exe"} | Select-Object -First 1).href
	[version]$version=$url.Split("/")[-2]

	if($version -eq "0.4.11") {
		$version = '0.4.11.2024042801'
	}
	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
