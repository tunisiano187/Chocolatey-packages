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
		# Get latest release from GitHub
		$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
		
		if (-not $tags) {
			throw "Could not fetch latest release from GitHub"
		}

		# Extract Windows x64 exe from release assets
		$asset = $tags.assets | Where-Object { $_.name -match 'Apache-NetBeans.*\.exe$' } | Select-Object -First 1
		
		if (-not $asset) {
			throw "Could not find Windows exe asset in latest release"
		}

		$url64 = $asset.browser_download_url
		
		# Parse version from release tag (e.g., "v28-build2" -> "28")
		$version = $tags.tag_name -replace 'v([0-9]+).*', '$1'
		
		if (-not $version -or $version -match '^v') {
			throw "Could not parse version from tag: $($tags.tag_name)"
		}

		# NetBeans versions don't include subversion, but Chocolatey needs one
		if ($version -notmatch '\.') {
			$version += ".0"
		}

		$Latest = @{ 
			URL64 = $url64
			Checksum64 = ""
			ChecksumType64 = ""
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
