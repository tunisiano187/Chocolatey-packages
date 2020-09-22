$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/GPUOpen-Tools/compressonator/releases'

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
    $installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match ".exe$"} | Where-Object {$_.href -match 'CLI'} | Select-Object -First 1).href
    $version = $($installer).split('_')[-1].replace('.exe',$env:ChocolateyPackageName)
    $url64 = "https://github.com$($installer)";

    return @{ URL64 = $url64; Version = $version }
}

update-package -ChecksumFor 64 -NoCheckChocoVersion
