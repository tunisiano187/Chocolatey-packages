$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.apc.com/shop/us/en/tools/software-firmware/N-8jkjh8Zh4vx14'

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
	$url32 = "$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'PCPE'} | Where-Object {$_.href -notmatch 'pdf'} | Where-Object {$_.href -match 'files'})[0].href)"
	$version = ($url32.Split('=|&') | Where-Object {$_ -match '.exe'}).replace('PCPE_','').replace('.exe','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
