$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

if ($MyInvocation.InvocationName -ne '.') {
    function global:au_SearchReplace {
        @{
            'tools/chocolateyInstall.ps1' = @{
                "(^[$]url64\s*=\s*)('.*')"            = "`$1'$($Latest.URL64)'"
                "(^[$]checksum64\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum64)'"
                "(^[$]checksumType64\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType64)'"
            }
        }
    }
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $apiUrl = 'https://api.github.com/repos/bitcoin/bitcoin/releases/latest'
    $release = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing
    $version = $release.tag_name -replace '^v', ''
    Update-Metadata -key "releaseNotes" -value $release.html_url

    $url64 = $release.assets.browser_download_url |
        Where-Object { $_ -match 'win64.*\.zip$' } |
        Where-Object { $_ -notmatch 'debug' } |
        Where-Object { $_ -notmatch 'unsigned' } |
        Select-Object -First 1

    if (-not $url64) { throw "Could not find win64 zip asset in bitcoin release $version" }

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor 64
