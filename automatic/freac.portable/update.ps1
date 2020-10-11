$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/enzo1982/freac/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "-windows.zip"} | Select-Object -First 1).href)"
    $url64 = $url32.Replace('windows.zip','windows-x64.zip')
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    $tags = Invoke-WebRequest 'https://api.github.com/repos/enzo1982/freac/releases' -UseBasicParsing | ConvertFrom-Json
    if($tag.tag_name -match $version) {
        foreach ($tag in $tags) {
            if($tag.prerelease -match "true") {
                $clnt = new-object System.Net.WebClient;
                $clnt.OpenRead("$($url32)").Close();
                $date = $([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
                $version = "$version-pre$($date)"
            }
        }
    }

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update-package