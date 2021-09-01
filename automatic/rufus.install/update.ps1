$ErrorActionPreference = 'Stop'
import-module au
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$toolsDir = join-path $toolsDir "tools"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"          = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $params = @{type='url';url='https://www.microsoft.com/en-us/p/rufus/9pc3h3v7q9ch';ring='RP';lang='en-US'}
    $files = (Invoke-WebRequest -Uri "https://store.rg-adguard.net/api/GetFiles" -Method POST -Body $params | Where-Object {$_ -match '.appx'})
    $url32 = ($files.Links | Where-Object {$_.outerText -match '.appx'})[0].href

    $version = (($files.Links | Where-Object {$_.outerText -match '.appx'})[0].outerText).split('_')[1]

    Invoke-WebRequest -Uri $url32 -OutFile "tools/Rufus-$version.appx"

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32
