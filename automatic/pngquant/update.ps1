$ErrorActionPreference = 'Stop'
Import-Module au
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
    # Download the Windows zip and read the version from pngquant.exe FileVersionInfo.
    # This avoids the mismatch caused by scraping pngquant.org, whose homepage advertises
    # the macOS/Linux version (currently 3.0.3) while the Windows binary lags behind (2.17.0).
    $tmpZip = Join-Path $env:TEMP 'pngquant-windows-version-check.zip'
    $tmpDir = Join-Path $env:TEMP 'pngquant-version-check'

    Invoke-WebRequest -Uri $url32 -OutFile $tmpZip -UseBasicParsing
    if (Test-Path $tmpDir) { Remove-Item $tmpDir -Recurse -Force }
    [System.IO.Compression.ZipFile]::ExtractToDirectory($tmpZip, $tmpDir)

    $exePath = Get-ChildItem -Path $tmpDir -Filter 'pngquant.exe' -Recurse |
               Select-Object -First 1 -ExpandProperty FullName
    $version = ([System.Diagnostics.FileVersionInfo]::GetVersionInfo($exePath)).FileVersion.Trim()

    Remove-Item $tmpZip -Force
    Remove-Item $tmpDir -Recurse -Force

    @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32 -NoCheckChocoVersion
