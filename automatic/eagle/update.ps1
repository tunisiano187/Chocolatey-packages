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
    import-module Wormies-AU-Helpers
	$url64 = Get-RedirectedUrl $release
	$version = $url64.split("_")[2]

	$Latest = @{ URL64 = $url64; Version = $version }
    return $Latest
}

update -ChecksumFor 64
