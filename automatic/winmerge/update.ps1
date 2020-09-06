$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/WinMerge/winmerge/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_GetLatest {
    $installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match ".exe$"} | Select-Object -First 2 | Sort-Object ).href
    $version=$($installer[0]).split('/')[-1].split('-')[1]
    $url32 = "https://github.com$($installer[1])";
	$url64 = "https://github.com$($installer[0])";

    $version = $installer -split '-|.exe' | select-object -Last 1 -Skip 2
    $tags = Invoke-WebRequest 'https://api.github.com/repos/WinMerge/winmerge/releases' -UseBasicParsing | ConvertFrom-Json
    foreach ($tag in $tags) {
        if($tag.tag_name -match $version) {
            if($tag.prerelease -match "true") {
                $clnt = new-object System.Net.WebClient;
                $clnt.OpenRead("https://github.com$($installer[0])").Close();
                $date = $([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
                $version = "$version-pre$($date)"
            }
        }
    }

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update-package
