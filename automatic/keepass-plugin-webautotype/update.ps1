$ErrorActionPreference = 'Stop'
import-module au

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

function global:au_GetLatest {
	cup -y keepass
	$url32 = "https://sourceforge.net/projects/webautotype/files/latest/download"
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match "files\/v"}).href[0].split('/')[-2].replace('v','')
	if($version -eq '6.4.0') {
		$version = '6.4.0.20200906'
	}

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
