$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/nteract/nteract/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
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
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    $url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "\.exe$"} | Select-Object -First 1

    if (-not $url32) {
        throw "Could not find .exe asset in release for $Owner/$repo"
    }
    Update-Metadata -key "releaseNotes" -value $tags.html_url

    # Strip leading 'v' and any '-stable.NNNNNN' build-metadata suffix
    # Tag format: v2.4.8-stable.202605142308 ? version 2.4.8
    # The timestamp suffix exceeds NuGet's 4-part int limits so we drop it entirely
    $version = $tags.tag_name -replace '^v', ''
    $version = $version -replace '-stable.*$', ''

    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32 -NoCheckChocoVersion
