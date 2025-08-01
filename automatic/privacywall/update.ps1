$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://cdn.privacywall.org/pro/PrivacyWallFirewallProSetup.exe'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
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
    $url32 = $releases
    $File = Join-Path $env:TEMP "privacywall.exe"

    Invoke-WebRequest -Uri $url32 -OutFile $File

    $version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32
