$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://proton.me/download/PassDesktop/win32/x64/version.json'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"              = "`$1'$($Latest.URL32)'"
            "(^[$]checksum64\s*=\s*)('.*')"         = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType64\s*=\s*)('.*')"     = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_BeforeUpdate {
	. ..\..\scripts\Get-FileVersion.ps1
	$FileVersion = Get-FileVersion $Latest.URL32
	$Latest.Checksum32 = $FileVersion.Checksum
	$Latest.ChecksumType32 = $FileVersion.checksumType
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $json = ConvertFrom-Json (invoke-WebRequest -Uri $releases).content
    $release = $json.Releases | Select-Object -First 1
    $version = (Get-Version $release.File.Url).Version

    return @{ URL32 = $release.File.Url; Checksum = $release.File.Sha512CheckSum; Version = $version }
}

update -ChecksumFor none
