$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$release = 'https://www.autodesk.com/eagle-download-win'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $url = Get-RedirectedUrl $release
    $version = $(Get-Version($url)).Version

	$Latest = @{ URL64 = $url; Version = $version }
    return $Latest
}

update -ChecksumFor 64 -NoCheckUrl
