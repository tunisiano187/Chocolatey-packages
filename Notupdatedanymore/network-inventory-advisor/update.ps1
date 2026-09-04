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
	# Without a browser-like User-Agent this site can serve a page that doesn't contain the
	# expected "Version X.Y" text at all, leaving $versionMatch.Matches empty -- indexing an
	# empty array with [0] throws an opaque "Cannot index into a null array" rather than a
	# useful message. Add a real UA and fail loudly instead if the pattern still isn't found.
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36'
	$regexPattern = 'Version (\d+(\.\d+)*)'
	$versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not find version pattern '$regexPattern' on $releases"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	$url32 = "https://www.network-inventory-advisor.com/download/network_inventory_advisor.exe"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
