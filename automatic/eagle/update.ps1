$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$release = 'https://eagle-updates.circuits.io/downloads/latest.html'

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
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $release -UseBasicParsing
    $url64 = ($page.Links | Where-Object {$_.href -match 'Win_64bit\.exe'} | Select-Object -First 1).href

    if (-not $url64) {
        throw "Could not find Windows 64-bit download link on eagle-updates.circuits.io"
    }

    # Extract version from URL like: .../9_6_2/Autodesk_EAGLE_9.6.2_English_Win_64bit.exe
    $versionMatch = $url64 | Select-String -Pattern 'EAGLE_([\d.]+)_English_Win'
    if (-not $versionMatch -or $versionMatch.Matches.Count -eq 0) {
        throw "Could not extract version from URL: $url64"
    }
    $version = $versionMatch.Matches[0].Groups[1].Value

    $Latest = @{ URL64 = $url64; Version = $version }
    return $Latest
}

update -ChecksumFor 64 -NoCheckUrl
