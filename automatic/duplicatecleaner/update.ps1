$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.digitalvolcano.co.uk/dcdownloads.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32 = "https://www.digitalvolcano.co.uk$(($page.Links | Where-Object {$_.href -match ".msi$"}).href)"
	$regexPattern = 'Version\s*(\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
