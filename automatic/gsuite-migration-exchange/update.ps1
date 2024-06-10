$ErrorActionPreference = 'Stop'
import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://support.google.com/a/answer/162794'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}


function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases
	$regexPattern = 'Release notes for (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value
	
	$url32 = "https://dl.google.com/exchangemigration/googleworkspacemigration.msi"
	$checksumType32 = 'sha256'
	$checksum32 = Get-RemoteChecksum -Algorithm $checksumType32 -Url $url32

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum32; ChecksumType32 = $checksumType32 }
	return $Latest
}

update -ChecksumFor none