import-module au

$releases = 'http://winmerge.org/downloads/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re32  = "winmerge-.*-Setup.exe"
    $url32 = $download_page.links | where-object href -match $re32 | select-object -First 1 -expand href
    $re64  = "winmerge-.*-x64-Setup.exe"
    $url64 = $download_page.links | where-object href -match $re64 | select-object -First 1 -expand href

    $version = $url32 -split '-|.exe' | select-object -Last 1 -Skip 2
    if($version -eq '2.16.6') {
        $version="$version.0"
    }

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update-package