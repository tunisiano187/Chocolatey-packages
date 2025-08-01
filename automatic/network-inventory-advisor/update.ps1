import-module chocolatey-AU

$releases = 'https://www.network-inventory-advisor.com/download.html'


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$page = Invoke-WebRequest -Uri $releases
	$regexPattern = 'Version (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	$version = $versionMatch.Matches[0].Groups[1].Value

	$url32 = "https://www.network-inventory-advisor.com/download/network_inventory_advisor.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
