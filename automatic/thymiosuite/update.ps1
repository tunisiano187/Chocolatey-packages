$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/Mobsya/aseba/releases/latest'

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
    $tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$urls = ($tags[0].assets | Where-Object {$_.browser_download_url -match "ThymioSuite"} | Where-Object {$_.browser_download_url -match 'exe'} | Where-Object {$_.browser_download_url -notmatch 'Proxy'} | Where-Object {$_.browser_download_url -match ".exe$"}).browser_download_url
    $url32 = $urls | Where-Object {$_ -match 'win32'}
    $url64 = $urls | Where-Object {$_ -match 'win64'}
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


    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update-package
