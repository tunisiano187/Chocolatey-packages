$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$appId = '25020447d4kq915'
$latestYmlUrl = "https://download.todesktop.com/$appId/latest.yml"

function global:au_SearchReplace {
    @{
        'tools/chocolateyinstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"           = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"      = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')"  = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_BeforeUpdate {
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $Latest.URL64
    $Latest.Checksum64    = $FileVersion.Checksum
    $Latest.ChecksumType64 = $FileVersion.ChecksumType
}

function global:au_AfterUpdate($Package) {
    Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $yml = (Invoke-WebRequest -Uri $latestYmlUrl -UseBasicParsing).Content

    $version = ($yml | Select-String -Pattern '(?m)^version:\s*(.+)').Matches[0].Groups[1].Value.Trim()

    $encodedVersion = [Uri]::EscapeDataString("Perplexity AI Setup $version-x64.exe")
    $url64 = "https://download.todesktop.com/$appId/$encodedVersion"

    return @{
        Version = $version
        URL64   = $url64
    }
}

update -ChecksumFor none
