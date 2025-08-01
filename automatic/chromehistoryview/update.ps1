$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$url32 = 'https://www.nirsoft.net/utils/chromehistoryview.zip'

Add-Type -AssemblyName System.IO.Compression.FileSystem


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page=Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/" -UseBasicParsing
	$regexPattern = 'ChromeHistoryView\ v(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
