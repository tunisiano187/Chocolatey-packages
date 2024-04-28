$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://node.minepi.com/node/'
$license = "https://github.com/minepi-finance/PI/blob/master/LICENSE"

function global:au_SearchReplace {
	@{
		".\legal\VERIFICATION.txt" = @{
			"(?i)(\s+x86:).*"                   = "`${1} $($Latest.URL64)"
			"(?i)(Get-RemoteChecksum).*"        = "`${1} $($Latest.URL64)"
			"(?i)(\s+checksum32:).*"            = "`${1} $($Latest.Checksum64)"
		  }
	}
}

function global:au_BeforeUpdate {
	Get-RemoteFiles -Purge -NoSuffix
	Invoke-WebRequest -Uri $license -OutFile ".\legal\LICENSE.txt"
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match ".exe"}).href
	[version]$version=$url.replace("%20"," ").Split(" ")[-1].replace('.exe','')

	if($version -eq "0.4.11") {
		$version = '0.4.11.2024042801'
	}
	$Latest = @{ URL32 = $url; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion