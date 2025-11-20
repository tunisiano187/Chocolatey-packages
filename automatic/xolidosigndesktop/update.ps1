$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$url32 = "https://www.xolido.com/instaladores/SetupXolidoSign.exe"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "SetupXolidoSign.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=$([System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion).trim()

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
