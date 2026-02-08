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
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    try {
        $url = Get-RedirectedUrl $release
        if (-not $url) {
            throw "Could not get redirect from $release"
        }
        $version = $(Get-Version($url)).Version

        if (-not $version) {
            throw "Could not extract version from URL"
        }

        $Latest = @{ URL64 = $url; Version = $version }
        return $Latest
    }
    catch {
        Write-Error "Error getting latest Eagle version: $_"
        throw
    }
}

update -ChecksumFor 64 -NoCheckUrl
