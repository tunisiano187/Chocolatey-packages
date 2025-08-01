$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/popcorn-official/popcorn-desktop/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
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
	$url64 = $tags.assets.browser_download_url | Where-Object {$_ -match "-Setup.exe$"} | Where-Object {$_ -match ".exe$"} | select-object -Last 1 -Skip 1
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $url64 -split 'v|/' | select-object -Last 1 -Skip 1
    if($tags.tag_name -match $version) {
        if($tags.prerelease -match "true") {
            $date = $tags.published_at.ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor 64
