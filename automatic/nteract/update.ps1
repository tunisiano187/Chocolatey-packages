$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/nteract/nteract/releases/latest'

function global:au_SearchReplace {
    @{
         "$($Latest.PackageName).nuspec" = @{
             "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
         }
     }
 }

function global:au_GetLatest {
    $tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | Where-Object {$_.browser_download_url -match "nteract-Setup"} | Where-Object {$_.browser_download_url -match ".exe$"}).browser_download_url
	$version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
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

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32 -NoCheckChocoVersion