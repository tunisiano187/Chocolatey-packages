$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://www.hikvision.com/en/support/tools/hitools/clea8b3e4ea7da90a9/"

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
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$regexPattern = 'data-href="([^"]+\.zip)"'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$url32 = $versionMatch.Matches[0].Groups[1].Value
	$regexPattern = '<span>V([\d\.]+)</span>'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
