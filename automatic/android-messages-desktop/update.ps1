$ErrorActionPreference = 'Stop'
import-module au

# $releases = 'https://api.github.com/repos/chrisknepper/android-messages-desktop/releases/latest'
$Owner = "chrisknepper"
$repo = "android-messages-desktop"

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
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
	$urls = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"}
    $url32 = $urls | Where-Object {$_ -match 'Setup'}
	$version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    Update-Metadata -key "releaseNotes" -value $tags.html_url
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }


    return @{ URL32 = $url32; Version = $version }
}

update