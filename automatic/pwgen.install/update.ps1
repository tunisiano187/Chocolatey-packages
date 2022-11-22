$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://sourceforge.net/projects/pwgen-win/files/Password%20Tech/'

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
	$url32 = "https://sourceforge.net/projects/pwgen-win/files/latest/download"
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "Tech\/"} | Where-Object {$_.href -notmatch 'css'}).href[0].split('/')[-2]

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
