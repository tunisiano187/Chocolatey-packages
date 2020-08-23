$ErrorActionPreference = 'Stop'
import-module au

$releases 		= 'http://argyllcms.com/downloadwin.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$urls = $((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where {$_.href -match 'exe.zip'}).href
	$url32 = $urls | where {$_ -match 'win32'}
	$url64 = $urls | where {$_ -match 'win64'}
	$version = $url32.split('V')[-1].split('_')[0]

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
