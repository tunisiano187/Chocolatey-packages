$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/Mobsya/aseba/releases/latest'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "ThymioSuite"} | Where-Object {$_.href -match 'exe'} | Where-Object {$_.href -notmatch 'Proxy'} | Select-Object -First 1).href)"
    $url64 = $url32.replace('win32','win64')

    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    
    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update-package -NoCheckChocoVersion