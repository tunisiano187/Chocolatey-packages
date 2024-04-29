$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://node.minepi.com/node/'

function global:au_SearchReplace {
	@{
		"legal\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum32:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/minepi-finance/PI/master/LICENSE" -OutFile "legal/LICENSE.txt"
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".exe"}).href
	[version]$version=$url.replace("%20"," ").Split(" ")[-1].replace('.exe','')

	if($version -eq "0.4.11") {
		$version = '0.4.11.2024042802'
	}
	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update