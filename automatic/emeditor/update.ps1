$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
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
    $page = Invoke-WebRequest -Uri 'https://www.emeditor.com/' -UseBasicParsing
    $version = ($page.Content | Select-String -Pattern 'EmEditor v([\d.]+) [Rr]eleased' -AllMatches).Matches[0].Groups[1].Value

    $url64 = "https://emeditor.blob.core.windows.net/emed64_${version}.msi"
    $checksumType64 = 'SHA256'
    $checksum64 = Get-RemoteChecksum -Url $url64 -Algorithm $checksumType64

    $Latest = @{
        URL64          = $url64
        Checksum64     = $checksum64
        ChecksumType64 = $checksumType64
        Version        = $version
    }
    return $Latest
}

update -ChecksumFor none
