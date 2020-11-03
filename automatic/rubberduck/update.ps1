$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/rubberduck-vba/Rubberduck/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "Rubberduck.Setup"} | Select-Object -First 1).href)"
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    $tags = Invoke-WebRequest 'https://api.github.com/repos/rubberduck-vba/Rubberduck/releases' -UseBasicParsing | ConvertFrom-Json
    foreach ($tag in $tags) {
        if($tag.tag_name -match $version) {
            if($tag.prerelease -eq $true) {
                $version = $url32.Split('/')[-1].replace('.exe','').split('u')[-1].replace('p.','')
            }
        }
    }

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32 -NoCheckChocoVersion