$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://sourceforge.net/projects/webautotype/files/'

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
	choco update -y keepass
	$url32 = "https://sourceforge.net/projects/webautotype/files/latest/download"
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match "files\/v"}).href[0].split('/')[-2].replace('v','')
	if($version -eq '6.8.1') {
		$version = '6.8.1.20220207'
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
