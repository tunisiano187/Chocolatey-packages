$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://addons.mozilla.org/api/v5/addons/addon/trafficlight/'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# addons.mozilla.org/en-US/firefox/addon/trafficlight/ now serves a JS "Client Challenge"
	# anti-bot page with no .xpi link in the static HTML -- confirmed live (plain page fetch
	# returns an empty React-shell document). The official AMO REST API isn't behind that
	# challenge and returns the same data cleanly.
	$addon = Invoke-RestMethod -Uri $releases -UseBasicParsing
	$url32 = $addon.current_version.file.url
	$version = $addon.current_version.version

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor none
