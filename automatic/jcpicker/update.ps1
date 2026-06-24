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
	# Use the canonical URL with trailing slash to avoid a 301 redirect that can cause
	# Invoke-WebRequest to return empty content on some PowerShell/Windows configurations.
	$baseUrl = 'https://annystudio.com/software/colorpicker'
	$page = Invoke-WebRequest -Uri "$baseUrl/" -UseBasicParsing

	# Use [Regex]::Match directly (more reliable than Select-String via pipeline on PS5/Windows).
	# Version is in "Latest version: <b>X.Y</b>" on the download page.
	$match = [Regex]::Match($page.Content, 'Latest version:\s*<b>([\d.]+)</b>')
	if (-not $match.Success) {
		throw "Could not extract version from annystudio.com page. Page structure may have changed."
	}
	$version = $match.Groups[1].Value.Trim()

	# Normalize to 3-part version (e.g. "6.2" -> "6.2.0") to match nuspec convention
	# and prevent AU string-compare from seeing a spurious version change.
	$parts = $version.Split('.')
	while ($parts.Count -lt 3) { $parts += '0' }
	$version = ($parts[0..2]) -join '.'

	# zip URL is /software/colorpicker/jcpicker.zip
	$url32 = "$baseUrl/jcpicker.zip"

	return @{ URL32 = $url32; Version = $version }
}

 update -ChecksumFor none
