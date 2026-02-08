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
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://annystudio.com/jcpicker.zip'

	$page = Invoke-WebRequest -Uri "https://annystudio.com/software/colorpicker" -UseBasicParsing
	$versionLinks = $page.Links | Where-Object {$_.href -match "jcpicker\.exe"}

	if (-not $versionLinks) {
		throw "Could not find jcpicker.exe download link"
	}

	$versionText = $versionLinks[0].outerHTML
	$versionMatch = $versionText | Select-String -Pattern '(\d+\.\d+)' -AllMatches

	if (-not $versionMatch.Matches) {
		throw "Could not extract version number from page"
	}

	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

 update -ChecksumFor none
