$ErrorActionPreference = 'Stop'
import-module au
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$releases = 'https://github.com/pbatard/rufus/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"          = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "rufus-"} | where-object {$_.href -match '.exe'} | Select-Object -First 1).href)"
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    $version = $version.replace('_','-')

    $toolsDir = Join-Path $toolsDir "tools"
    $file = Join-Path $toolsDir "Rufus-$version.appx"
    Invoke-WebRequest -Uri $url32 -OutFile $file

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32