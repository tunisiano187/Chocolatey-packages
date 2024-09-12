$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_BeforeUpdate {
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion32 = Get-FileVersion $Latest.URL32
    $Latest.Checksum32 = $fileinfo32.Checksum
    $Latest.ChecksumType32 = $FileVersion32.checksumType
    $FileVersion64 = Get-FileVersion $Latest.URL64
    $Latest.Checksum64 = $fileinfo64.Checksum
    $Latest.ChecksumType64 = $FileVersion64.checksumType
  }

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = Get-RedirectedUrl "https://allwaysync.com/content/download/allwaysync.exe"
    $url64 = Get-RedirectedUrl "https://allwaysync.com/content/download/allwaysync-x64.exe"
    $version = Get-Version $url32.Replace('-','.')

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update -ChecksumFor none