$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://cassandra.apache.org/_/download.html'

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
	$url32 = ($page.Links | Where-Object {$_.href -match ".tar.gz$"} | Where-Object {$_.href -notmatch 'beta'} | Select-Object -First 1).href
	$checksumurl = ($page.Links | Where-Object {$_.href -match ".tar.gz.sha"} | Where-Object {$_.href -notmatch 'beta'} | Select-Object -First 1).href
	$page = Invoke-WebRequest -Uri $url32 -UseBasicParsing
	$url32 = ($page.Links | Where-Object {$_.href -match ".tar.gz$"} | Where-Object {$_.href -notmatch 'beta'} | Select-Object -First 1).href
	$checksumType = ($checksumurl.split('.'))[-1]
	$checksum = (Invoke-WebRequest -Uri $checksumurl -UseBasicParsing).Content.trim()
	$version = $url32.split('/') | Where-Object {$_ -Match "[0-9].[0-9]"} | Where-Object {$_ -notmatch 'tar'}

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum; ChecksumType32 = $checksumType }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
