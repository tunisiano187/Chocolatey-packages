$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$Owner = 'zaproxy'
$repo  = 'zaproxy'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
            "(^\`$url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^\`$checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^\`$url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^\`$checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_BeforeUpdate {
    . ..\..\scripts\Get-FileVersion.ps1
    $fv32 = Get-FileVersion $Latest.URL32
    $Latest.Checksum32     = $fv32.Checksum
    $Latest.ChecksumType32 = $fv32.ChecksumType
    $fv64 = Get-FileVersion $Latest.URL64
    $Latest.Checksum64     = $fv64.Checksum
    $Latest.ChecksumType64 = $fv64.ChecksumType
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $release = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    $tag     = $release.tag_name                          # e.g. v2.17.0
    $semver  = $tag -replace '^v', ''                    # e.g. 2.17.0
    $date    = $release.published_at.ToString('yyyyMMdd') # e.g. 20251215
    $version = "$semver.$date"

    $urls = $release.assets.browser_download_url
    $url32 = $urls | Where-Object { $_ -match 'windows-x32\.exe$' } | Select-Object -First 1
    $url64 = $urls | Where-Object { $_ -match 'windows\.exe$' -and $_ -notmatch 'x32' } | Select-Object -First 1

    Update-Metadata -key 'releaseNotes' -value "https://www.zaproxy.org/docs/desktop/releases/$semver"

    return @{
        Version = $version
        URL32   = $url32
        URL64   = $url64
    }
}

update -ChecksumFor none
