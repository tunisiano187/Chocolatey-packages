$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'http://vaemendis.net/ubooquity/static2/download'

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
	$url = 'http://vaemendis.net/ubooquity/downloads/'

	$pageContent = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$versionPattern = 'Version\s+(\d+\.\d+\.\d+)'
	$versionMatch = [regex]::Match($pageContent, $versionPattern)

	$version=$versionMatch.Groups[1].Value
	$pageContent = Invoke-WebRequest -Uri $url -UseBasicParsing
	$url32 = "$($url)$(($pageContent.Links | Where-Object {$_ -match $version}).href)"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
