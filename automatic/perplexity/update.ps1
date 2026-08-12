$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$baseUrl = 'https://download.todesktop.com/25020447d4kq915'

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
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
    $yamlContent = (Invoke-WebRequest -Uri "$baseUrl/latest.yml" -UseBasicParsing).Content

    # Parse version from YAML
    $version = [regex]::Match($yamlContent, '(?m)^version:\s+(.+)$').Groups[1].Value.Trim()
    if (-not $version) { throw "Could not parse version from latest.yml" }

    # Find the x64 file entry and its sha512 checksum
    # The YAML lists files in order: universal, x64, arm64
    $sha512Base64 = $null
    $lines = $yamlContent -split "`n"
    $inX64Block = $false
    foreach ($line in $lines) {
        if ($line -match "url:\s+Perplexity AI Setup .+-x64\.exe") {
            $inX64Block = $true
        } elseif ($inX64Block -and $line -match "^\s+sha512:\s+(.+)$") {
            $sha512Base64 = $Matches[1].Trim()
            break
        } elseif ($inX64Block -and $line -match "^\s+-\s+url:") {
            # Entered next file block — x64 sha512 not found
            break
        }
    }
    if (-not $sha512Base64) { throw "Could not find x64 sha512 in latest.yml" }

    # Convert SHA512 from base64 to lowercase hex (Chocolatey format)
    $sha512Hex = ([System.Convert]::FromBase64String($sha512Base64) | ForEach-Object { '{0:x2}' -f $_ }) -join ''

    # Build the URL-encoded download URL (filename has spaces)
    $fileName = "Perplexity AI Setup $version-x64.exe"
    $url64 = "$baseUrl/$([System.Uri]::EscapeDataString($fileName))"

    Write-Output "Version : $version"
    Write-Output "URL64   : $url64"

    return @{
        Version        = $version
        URL64          = $url64
        Checksum64     = $sha512Hex
        ChecksumType64 = 'sha512'
    }
}

update -ChecksumFor none
