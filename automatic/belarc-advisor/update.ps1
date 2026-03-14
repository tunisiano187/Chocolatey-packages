$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$url32 = "https://downloads.belarc.com/advisor/advisorinstaller.exe"
function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
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
	$FileVersion = Get-FileVersion $url32
    $version = $FileVersion.Version
    $Checksum32 = $FileVersion.Checksum

    $Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $Checksum32; ChecksumType32 = $FileVersion.ChecksumType }
    return $Latest
}

update -ChecksumFor none
