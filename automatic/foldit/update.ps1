$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$release = 'https://files.ipd.uw.edu/pub/foldit/Foldit-win_x64.exe'

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_GetLatest {
	# The Last-Modified header on the download URL is stale (stuck at 2022-09-15)
	# even though Foldit is actively updated. Scrape the release number from the
	# releases page instead.
	$releasePage = Invoke-WebRequest -Uri 'https://fold.it/releases' -UseBasicParsing
	if ($releasePage.Content -match 'Release\s+(\d+)') {
		$releaseNumber = [int]$matches[1]
		$version = "${releaseNumber}.0.0"
	} else {
		throw "Could not determine Foldit release number from releases page"
	}

	Write-Output "Version : $version"
	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
