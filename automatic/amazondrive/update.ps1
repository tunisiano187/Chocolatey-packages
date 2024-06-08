$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.amazon.com/photos/download%3Fref_=APH_D_T751'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $File = Join-Path $env:TEMP "chocolatey\AmazonPhotosSetup.exe"
    Invoke-WebRequest -uri $releases -OutFile $File
    $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

    return @{ URL32 = $releases; Version = $version }
}

update