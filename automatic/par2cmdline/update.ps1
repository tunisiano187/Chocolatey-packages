$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://api.github.com/repos/Parchive/par2cmdline/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".zip$"}
    $url32 = $urls | Where-Object {$_ -match 'x86'} | Select-Object -First 1
    $url64 = $urls | Where-Object {$_ -match 'x64'} | Select-Object -First 1
	Update-Metadata -key "releaseNotes" -value $tags.html_url
	
	# Extract version from tag name, removing 'v' prefix
	$version = $tags.tag_name -replace '^v'
	
	if ($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -NoCheckChocoVersion
