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
		# Windows .exe asset — typically tagged v{N}-build{x} or nb{N}-sans.
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

update -ChecksumFor none -NoCheckChocoVersion
