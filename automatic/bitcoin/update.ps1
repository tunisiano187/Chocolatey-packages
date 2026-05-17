$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://github.com/bitcoin/bitcoin/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

if ($MyInvocation.InvocationName -ne '.') {
    function global:au_SearchReplace {
        @{
            "$($Latest.PackageName).nuspec" = @{
                "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
            }
        }
    }
}

function global:au_GetLatest {
    $apiUrl = 'https://api.github.com/repos/bitcoin/bitcoin/releases/latest'
    $release = Invoke-RestMethod -Uri $apiUrl -UseBasicParsing
    $version = $release.tag_name -replace '^v', ''

    return @{
        Version = $version
    }
}

update -ChecksumFor none
