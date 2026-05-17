$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://salesapi.thebrain.com/?a=doDirectDownload&id=14001'

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
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# salesapi.thebrain.com redirects to the latest installer URL at updater.thebrain.com
	$url32 = Get-RedirectedUrl $releases
	if (-not $url32) {
		throw "Could not get redirect from TheBrain download API"
	}

	# URL format: https://updater.thebrain.com/files/TheBrain%2014.0.116.0%20Installer.exe
	$versionMatch = $url32 | Select-String -Pattern 'TheBrain%20([\d.]+)%20Installer'
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from URL: $url32"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion