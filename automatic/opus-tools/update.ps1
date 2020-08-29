$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.opus-codec.org/downloads/'

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
	$urls = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'opus/win'} | Where-Object {$_.href -match '-win'}).href
	$url32 = $urls[0]
	$version = $url32.split('-')[-2]

	return @{ 	URL32 = $url32
				Version = $version
	}
}

update -ChecksumFor 32 -NoCheckChocoVersion