$ErrorActionPreference = 'Stop'
import-module au

#$releases = 'https://github.com/GPUOpen-Tools/compressonator/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $tags = Invoke-WebRequest 'https://api.github.com/repos/GPUOpen-Tools/compressonator/releases' -UseBasicParsing | ConvertFrom-Json
    $url64 = ($tags[0].assets | where {$_.browser_download_url -match ".exe$"}).browser_download_url | Where-Object {$_ -match 'CLI'} | Select-Object -First 1
    $version = ($tags[0].tag_name).replace('V','')


    return @{ URL64 = $url64; Version = $version }
}

update-package -ChecksumFor 64 -NoCheckChocoVersion
