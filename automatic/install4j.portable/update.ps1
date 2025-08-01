$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://www.ej-technologies.com/download/install4j/files'

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
	$url = ((Invoke-WebRequest -Uri $releases).Links | Where-Object {$_.href -match "windows-x64"} | Where-Object {$_.href -match "zip$"} ).href
	$pageContent = Invoke-WebRequest -Uri $releases
	$regexPattern = 'version:\s*(\d+(\.\d+)*)'
	$versionMatch = $pageContent.Content | Select-String -Pattern $regexPattern -AllMatches

	$version = $versionMatch.Matches[0].Groups[1].Value
	#$checksumType = "SHA512"
	#$checksum = Get-RemoteChecksum -Url $url -Algorithm $checksumType
	Update-Metadata -key "copyright" -value "© $(Get-Date -Format "yyyy") ej-technologies GmbH"

	$Latest = @{ URL32 = $url; Version = $version}
	return $Latest
}

update -ChecksumFor 32
