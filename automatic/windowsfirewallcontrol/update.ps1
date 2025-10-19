$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://www.binisoft.org/wfc"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32="https://www.binisoft.org/$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'}).href)"

    $File = Join-Path($(Split-Path $env:TEMP)) "wfcsetup.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
    if($version -eq "6.9.2.0") {
        $version = "6.9.2.2023091101"
    }

	$Latest = @{ URL32 = $url32; Version = $version }

    return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion