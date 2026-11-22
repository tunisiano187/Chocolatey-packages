$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://api.github.com/repos/yang991178/fluent-reader/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"}
	# Upstream dropped 32-bit Windows builds as of v1.3.0 (package-win-ci went from
	# "electron-builder -w --x64 ... && electron-builder -w --ia32 ..." to just "--x64"),
	# so there is no longer an asset matching "x86" -- only ever filter/ship the 64-bit one.
	$url64 = $urls | Where-Object {$_ -match "x64"}
	if (-not $url64) { throw "Could not find an x64 .exe asset in the latest release: $($tags.html_url)" }
	$version = $tags.tag_name.Replace('v','')
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	. ..\..\scripts\Get-GithubRepositoryLicense.ps1
	Update-Metadata -key "licenseUrl" -value $(Get-GithubRepositoryLicense $Owner $repo).download_url
	if($tags.prerelease -match "true") {
		$date = $tags.published_at.ToString("yyyyMMdd")
		$version = "$version-pre$($date)"
	}

	$Latest = @{ URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor 64
