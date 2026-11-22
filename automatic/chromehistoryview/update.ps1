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
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page=Invoke-WebRequest -Uri "https://www.nirsoft.net/utils/" -UseBasicParsing
	$regexPattern = 'ChromeHistoryView\ v(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	# nirsoft.net lists a 2-component version ("1.53"), but chocolatey.org's feed already has
	# this package at 3 components ("1.53.0" -- confirmed live, /packages/chromehistoryview/1.53
	# 404s while /1.53.0 is 200). AU's feed-existence check is an exact string match, so without
	# padding it never finds "1.53.0" and pushes "1.53" anyway, which choco pack then normalizes
	# to "1.53.0" at upload time -- already live, so the push 409s every run. Pad to 3 components
	# (same pattern already used by jcpicker in this repo) so the check actually matches.
	$parts = $version.Split('.')
	while ($parts.Count -lt 3) { $parts += '0' }
	$version = ($parts[0..2]) -join '.'

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
