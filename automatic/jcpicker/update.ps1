$ErrorActionPreference = 'Stop'

import-module chocolatey-AU

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(^Version\s+:).*"  	= "`${1} $($Latest.Version)"
			"(^URL\s+:).*"      	= "`${1} $($Latest.URL32)"
			"(^Checksum\s+:).*" 	= "`${1} $($Latest.Checksum32)"
			"(^ChecksumType\s+:).*" = "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	Write-Output "Downloading jcpicker $($Latest.Version) file"
	Get-RemoteFiles -Purge -NoSuffix
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$baseUrl = 'https://annystudio.com/software/colorpicker'
	$page = Invoke-WebRequest -Uri $baseUrl -UseBasicParsing

	# Version is in "Latest version: <b>X.Y</b>"  -  not inside the link outerHTML
	$versionMatch = $page.Content | Select-String -Pattern 'Latest version:\s*<b>(\d+\.\d+)</b>' -AllMatches
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from annystudio.com page. Page structure may have changed."
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	# zip URL is /software/colorpicker/jcpicker.zip, not the root-level path used before
	$url32 = "$baseUrl/jcpicker.zip"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

 update -ChecksumFor none
