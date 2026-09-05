import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1
. ..\..\scripts\Get-FileVersion.ps1

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	# SourceForge latest/download redirects to the jar file URL which contains the version
	$redirectUrl = Get-RedirectedUrl 'http://sourceforge.net/projects/projectlibre/files/latest/download'
	if (-not $redirectUrl) {
		throw "Could not follow SourceForge redirect"
	}

	# Extract version from URL like: .../ProjectLibre/1.9.8/projectlibre-1.9.8.jar
	$versionMatch = $redirectUrl | Select-String -Pattern '/ProjectLibre/([\d.]+)/'
	if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
		throw "Could not extract version from redirect URL: $redirectUrl"
	}
	$version = $versionMatch.Matches[0].Groups[1].Value

	# Keep the permanent SourceForge /download URL — do NOT call Get-RedirectedUrl here.
	# Get-RedirectedUrl returns CDN mirror URLs with query params (?ts=...&use_mirror=...)
	# that WebClient.DownloadFile treats as illegal path characters, breaking AU's checksum
	# logic. Invoke-WebRequest (used by Get-FileVersion) follows the redirect transparently.
	# Uses the real upstream $version -- the collision bump below must not affect this URL.
	$url32 = "https://sourceforge.net/projects/projectlibre/files/ProjectLibre/$version/ProjectLibre-$version.msi/download"

	$FileVersion = Get-FileVersion $url32 -checksumType 'sha256'

	# Same root cause as netbeans/cports: the single-package push handler in .appveyor.yml
	# doesn't commit back to git, so the nuspec stays at 0.0 forever and a bare version-string
	# comparison against it always looks "new" even when SourceForge hasn't actually released
	# anything, hitting 409 Conflict every run. Compare the freshly-downloaded checksum against
	# what's already committed in chocolateyInstall.ps1 instead -- ground truth for "did the
	# binary actually change" -- and only bump the *reported* version (after the URL above is
	# already built from the real upstream one) when it genuinely has, using the msi's own
	# Last-Modified date rather than "today" so repeated checks before a successful commit
	# lands don't each mint a further new version. Same technique already used by windjview.
	#
	# This alone isn't enough, though: since the nuspec never advances off 0.0 either way, every
	# subsequent run recomputes the exact same version (same stale committed checksum, same
	# unchanged Last-Modified date) and, with -NoCheckChocoVersion still forcing a push attempt
	# regardless, keeps re-pushing a version that already succeeded once -- 409 forever, just on
	# a fixed version instead of a new one each day (confirmed live: exactly this, the day after
	# this technique first shipped -- same bug independently found and fixed for cports).
	# -NoCheckChocoVersion is removed below for that reason: AU's own default check against the
	# live chocolatey.org feed correctly recognizes an already-published version and skips
	# cleanly, with no error and no push attempt, and still lets a genuinely new future version
	# through untouched.
	$installContent = Get-Content "$PSScriptRoot\tools\chocolateyInstall.ps1" -Raw
	$current_checksum = [regex]::Match($installContent, "\`$checksum\s*=\s*'([a-fA-F0-9]+)'").Groups[1].Value
	if ($current_checksum -and $current_checksum -ne $FileVersion.Checksum) {
		try {
			$lastModified = (Invoke-WebRequest -Uri $url32 -Method Head -UseBasicParsing).Headers['Last-Modified']
			$dateStamp = ([datetime]::Parse($lastModified)).ToString('yyyyMMdd')
		} catch {
			$dateStamp = Get-Date -Format 'yyyyMMdd'
		}
		$version = "$version.$dateStamp"
	}

	$Latest = @{
		URL32          = $url32
		Version        = $version
		Checksum32     = $FileVersion.Checksum
		ChecksumType32 = $FileVersion.ChecksumType
	}
	return $Latest
}

update -ChecksumFor none
