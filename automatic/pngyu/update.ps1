$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://nukesaq88.github.io/Pngyu/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page=Invoke-WebRequest -uri $releases
    $version = $page.Content | Where-Object { $_ -match 'win:[0-9\.]+'}
    $version = $Matches[0].Split(':')[1]
    $exist = $page.Content | Where-Object { $_ -match 'win_[0-9]+'}
    if($Matches[0]) {
        $url32 = "https://nukesaq88.github.io/Pngyu/download/Pngyu_win_$($version.Replace('.','')).zip"
    } else {
        $version = "0.0"
    }
	if($version -eq '1.0.1') {
        $version='1.0.1.20221128'
    }

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -NoCheckChocoVersion