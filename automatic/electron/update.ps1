$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/electron/electron/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match "electron-"} | Where-Object {$_ -match ".zip$"}
	# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- confirmed
	# live: v43.4.1 still has electron-v43.4.1-win32-ia32.zip, v44.2.0 only has win32-x64.zip.
	# The old code kept a separate $url32 filter that silently resolved to $null once ia32
	# assets disappeared, which AU's own URL validation rejected with the opaque "URL syntax
	# is invalid: " (empty). 64-bit only from here on, mapped to the package's single (non
	# -64-suffixed) URL/checksum slot; if Electron ever re-adds a 32-bit build this won't pick
	# it up automatically.
	$url32 = $urls | Where-Object {$_ -match 'win32-x64.zip'}
	if (-not $url32) { throw "Could not find a win32-x64.zip asset in the latest Electron release" }
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	Write-Output 'Checking version'

	$version = $tags.tag_name.replace('v','')
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
