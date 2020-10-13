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
	$link = "https://www.apc.com/$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'PowerChute-Personal-Edition'} | Where-Object {$_.href -notmatch 'pdf'})[0].href)"
	$url32 = ((Invoke-WebRequest -Uri $link -UseBasicParsing).Links | Where-Object  {$_.href -match 'exe'})[0].href
	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'download.sc'})[0].href.split('/|v')[-2].replace('-','.')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
