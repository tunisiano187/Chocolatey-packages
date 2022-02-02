$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/enzo1982/freac/releases/latest'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).portable`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "-windows-x64.zip"} | Select-Object -First 1).href)"
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    $tags = Invoke-WebRequest 'https://api.github.com/repos/enzo1982/freac/releases' -UseBasicParsing | ConvertFrom-Json
    foreach ($tag in $tags) {
        if($tag.tag_name -match $version) {
            if($tag.prerelease -match "true") {
                $clnt = new-object System.Net.WebClient;
                $clnt.OpenRead("$($url32)").Close();
                $date = $($clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
                $version = "$version-pre$($date)"
            }
        }
    }

    return @{ URL32 = $url32; Version = $version }
}

update-package -CheckSumFor none