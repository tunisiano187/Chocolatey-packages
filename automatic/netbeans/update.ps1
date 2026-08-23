$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://installers.friendsofapachenetbeans.org/'
$github = 'https://github.com/Friends-of-Apache-NetBeans/netbeans-installers/releases/latest'
$Owner = $github.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $github.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL64
	$Latest.Checksum64 = $FileVersion.Checksum
	$Latest.ChecksumType64 = $FileVersion.checksumType
}

function global:au_GetLatest {
	try {
		# The GitHub /releases/latest endpoint may return a release without Windows exe assets
		# (e.g. nb29-zulufx-25 only has RPM/DEB). Iterate recent releases to find one with a
		# Windows .exe asset  -  typically tagged v{N}-build{x} or nb{N}-sans.
		$apiUrl = "https://api.github.com/repos/$Owner/$repo/releases?per_page=10"
		$headers = @{ 'User-Agent' = 'chocolatey-au' }
		$releaseList = Invoke-RestMethod -Uri $apiUrl -Headers $headers -UseBasicParsing

		$asset = $null
		$release = $null
		foreach ($r in $releaseList) {
			$a = $r.assets | Where-Object { $_.name -match 'Apache-NetBeans.*\.exe$' } | Select-Object -First 1
			if ($a) { $asset = $a; $release = $r; break }
		}

		if (-not $asset) {
			throw "Could not find a Windows exe asset in the last 10 FoAN releases"
		}

		$url64 = $asset.browser_download_url

		# Parse version from tag: handles "v28-build2" -> "28", "nb30-sans" -> "30"
		$version = $release.tag_name -replace '^(?:v|nb)([0-9]+).*$', '$1'
		if (-not $version -or $version -eq $release.tag_name) {
			throw "Could not parse version from tag: $($release.tag_name)"
		}
		# Chocolatey requires at least two version segments
		if ($version -notmatch '\.') {
			$version += ".0"
		}

		# Collision bump, round 2: 31.0.0 went live with the broken nb31-rc1 URL, so this was
		# first bumped to 31.0.1 to force a fresh push with the corrected stable nb31 asset --
		# and that push DID succeed (confirmed live: 31.0.1 is now the published version with
		# the correct URL). But the push happened via the PR-merge-triggered single-package
		# path in .appveyor.yml, which -- unlike the daily scheduled au/update_all.ps1 job --
		# has no git credentials wired in and never commits back to master. So the nuspec here
		# stayed at 0.0, and every run since keeps recomputing "31.0.1" and getting rejected
		# with a 409 Conflict, since chocolatey.org already has it. The package itself is fine
		# now (31.0.1 has the correct URL) -- this is purely to stop the daily 409 noise by
		# giving AU one more never-before-seen version to successfully push and finally commit.
		# If nb32 (or later) lands upstream before this runs again, this branch goes dead on
		# its own and nothing further is needed; if this exact loop recurs, the fix is the same
		# -- bump the hardcoded target version again.
		if ($version -eq "31.0") { $version = "31.0.2" }

		$Latest = @{
			URL64 = $url64
			Checksum64 = ""
			ChecksumType64 = "sha256"
			Version = $version
		}
		return $Latest
	}
	catch {
		Write-Error "Error fetching latest NetBeans release: $_"
		throw
	}
}

update -ChecksumFor none
