$ErrorActionPreference = 'Stop'
import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://support.google.com/a/answer/1283788'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
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

	$url32 = "https://dl.google.com/outlookmigration/enterprise_outlookmigration.msi"
	$url64 = "https://dl.google.com/dl/outlookmigration/x64/enterprise_outlookmigration.msi"
	. ..\..\scripts\Get-FileVersion.ps1
	$FileInfo = Get-FileVersion $url32
	$FileInfo64 = Get-FileVersion $url64

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $FileInfo.Checksum; ChecksumType32 = $FileInfo.ChecksumType; URL64 = $url64; Checksum64 = $FileInfo64.Checksum; ChecksumType64 = $FileInfo.ChecksumType }
	return $Latest
}

update -ChecksumFor none
