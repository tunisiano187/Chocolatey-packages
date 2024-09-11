$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://proton.me/download/PassDesktop/win32/x64/version.json'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"              = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"         = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $json = ConvertFrom-Json (invoke-WebRequest -Uri $releases).content
    $release = $json.Releases | Select-Object -First 1
    $version = (Get-Version $release.File.Url).Version

    return @{ URL64 = $release.File.Url; Checksum = $release.File.Sha512CheckSum; Version = $version }
}

update -ChecksumFor 64 -NoCheckChocoVersion