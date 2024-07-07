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
    $of = "$env:temp/eagle.exe"
    Invoke-WebRequest -Uri $release -OutFile $of -UseBasicParsing

	[Version]$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($of).ProductVersion.trim()
    $checksumtype = $env:hash_algo
    $checksum = Get-FileHash -Path $of -Algorithm $env:hash_algo

	$Latest = @{ URL64 = $release; Version = $version; Checksum64 = $checksum; ChecksumType64 = $checksumtype }
    return $Latest
}

update -ChecksumFor none -NoCheckUrl
