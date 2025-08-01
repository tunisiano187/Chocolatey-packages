$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.ossec.net/download-ossec/'

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
	$url32 = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'ossec-agent-win32'} | Where-Object {$_.href -notmatch '.asc'}).href | Select-Object -Unique -First 1
	$version = $url32.split('-')[-2]

	return @{ 	URL32 = $url32
				Version = $version
	}
}

update -ChecksumFor 32
