$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'http://paul.glagla.free.fr/captureflux_en.htm'

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
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url32 = "https://paulglagla.com/$($page.Links.href | Where-Object {$_ -match "zip$"} | Select-Object -First 1)"
	$regexPattern = '(\d+(\.\d+)*)</b>'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value


	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
