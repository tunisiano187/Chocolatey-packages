$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$repoOwner = 'dsccommunity'
$repoName  = 'HyperVDsc'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
            "(^\`$url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^\`$checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^\`$checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $release = Invoke-RestMethod "https://api.github.com/repos/$repoOwner/$repoName/releases/latest"
    $version = $release.tag_name -replace '^v', ''
    $url32   = "https://github.com/$repoOwner/$repoName/archive/refs/tags/$($release.tag_name).zip"
    return @{ Version = $version; URL32 = $url32 }
}

update -ChecksumFor 32 -NoCheckChocoVersion
