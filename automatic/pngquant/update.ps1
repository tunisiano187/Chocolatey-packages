$ErrorActionPreference = 'Stop'
Import-Module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$url32 = 'https://pngquant.org/pngquant-windows.zip'

Add-Type -AssemblyName System.IO.Compression.FileSystem

function global:au_SearchReplace {
    @{
        'tools/chocolateyInstall.ps1' = @{
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
    # Download the Windows zip and extract the version from the embedded string in pngquant.exe.
    # pngquant is a Rust binary with no PE FileVersionInfo resource; the version string
    # "X.Y.Z (Month YYYY)" is embedded as a literal. This avoids the mismatch caused by
    # scraping pngquant.org, whose homepage advertises the macOS/Linux version while the
    # Windows binary lags behind.
    $tmpZip = Join-Path $env:TEMP 'pngquant-windows-version-check.zip'
    $tmpDir = Join-Path $env:TEMP 'pngquant-version-check'

    Invoke-WebRequest -Uri $url32 -OutFile $tmpZip -UseBasicParsing
    if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tmpZip, $tmpDir)

    $exePath = Get-ChildItem -Path $tmpDir -Filter 'pngquant.exe' -Recurse |
               Select-Object -First 1 -ExpandProperty FullName
    if (-not $exePath) { throw 'pngquant.exe not found in extracted zip' }

    # pngquant is a Rust binary with no PE FileVersionInfo resource.
    # The version string "X.Y.Z (Month YYYY)" is embedded as a string literal.
    $bytes = [System.IO.File]::ReadAllBytes($exePath)
    $text  = [System.Text.Encoding]::ASCII.GetString($bytes)
    if ($text -notmatch '(\d+\.\d+\.\d+) \((?:January|February|March|April|May|June|July|August|September|October|November|December) \d{4}\)') {
        throw 'Cannot detect version from pngquant.exe binary string'
    }
    $version = $Matches[1]

    Remove-Item $tmpZip -Force
    Remove-Item $tmpDir -Recurse -Force

    @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32 -NoCheckChocoVersion
