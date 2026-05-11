$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

# Changed from drivermax.informer.com (Cloudflare IUAM) to filecroco.com which is accessible.
# Direct download confirmed working (HTTP 200): https://www.drivermax.com/soft/dmx/drivermax.exe
$releases = 'https://www.filecroco.com/download-drivermax/'

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
	$regexPattern = 'DriverMax\s+(\d+\.\d+(?:\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract DriverMax version from $releases"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value
	$url32 = "https://www.drivermax.com/soft/dmx/drivermax.exe"

	return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32 -NoCheckChocoVersion
