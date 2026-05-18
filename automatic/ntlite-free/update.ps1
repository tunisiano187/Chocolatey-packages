import-module chocolatey-AU

$releases = 'https://www.ntlite.com/download/'


function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url(32)?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum(32)?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType(32)?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64?\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64?\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64?\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	# NTLite download page is a Next.js SPA; parse embedded URLs from the raw HTML
	$page = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$url64 = ($page.Content | Select-String -Pattern 'https://downloads\.ntlite\.com/files/NTLite_setup_x64\.exe' -AllMatches).Matches[0].Value
	if (-not $url64) {
		throw "Could not find 64-bit download URL on $releases"
	}

	# x86 legacy only — skip if unavailable; fall back to x64
	$url32match = ($page.Content | Select-String -Pattern 'https://downloads\.ntlite\.com/files/NTLite_setup_x86[^"]*\.exe' -AllMatches).Matches
	$url32 = if ($url32match) { $url32match[0].Value } else { $url64 }

	# Version is date-based (e.g. 2026.05.11014); scrape from changelog
	$changelog = Invoke-WebRequest -Uri 'https://www.ntlite.com/changelog/' -UseBasicParsing
	$versionMatch = $changelog.Content | Select-String -Pattern '20\d\d\.\d{2}\.\d+' -AllMatches
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from ntlite.com/changelog/"
	}
	$version = $versionMatch.Matches[0].Value

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion