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

    # Bitcoin Core does not publish binary assets to GitHub releases.
    # Binaries are hosted at bitcoincore.org/bin/.
    $url64 = "https://bitcoincore.org/bin/bitcoin-core-$version/bitcoin-$version-win64-setup.exe"

    return @{ URL64 = $url64; Version = $version }
}

update -ChecksumFor 64
