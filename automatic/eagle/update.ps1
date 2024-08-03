$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://www.autodesk.com/eagle-download-win'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $release
    
	$Latest = @{ URL64 = $release; Version = $FileVersion.Version; Checksum64 = $FileVersion.Checksum; ChecksumType64 = $FileVersion.ChecksumType }
    return $Latest
}

update -ChecksumFor none -NoCheckUrl
