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

	$FileVersion = Get-FileVersion $url32

	# Collision bump: same root cause as netbeans/cports -- the single-package push handler in
	# .appveyor.yml doesn't commit back to git, so the nuspec stays at 0.0 forever and every run
	# recomputes the identical already-published version (1.9.8), hitting 409 Conflict. Bump the
	# *reported* version only (after the URL above is already built from the real one) to a
	# version chocolatey.org has never seen, to break the loop. Uses a FIXED literal, not
	# Get-Date: SourceForge's ProjectLibre-1.9.8.msi is unchanged day to day (same checksum),
	# so a dynamic today's-date suffix would mint a brand-new never-before-seen version every
	# single day forever instead of stopping after one successful push. If this exact loop
	# recurs (still stuck, no new upstream release), bump this hardcoded literal again by hand.
	if ($version -eq "1.9.8") { $version = "1.9.8.20260904" }

	$Latest = @{
		URL32          = $url32
		Version        = $version
		Checksum32     = $FileVersion.Checksum
		ChecksumType32 = $FileVersion.ChecksumType
	}
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion
