$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/pbatard/rufus/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"          = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $url32 = "https://github.com$($((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_.href -match "rufus-"} | where-object {$_.href -match '.exe'} | Select-Object -First 1).href)"
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    $tags = Invoke-WebRequest 'https://api.github.com/repos/pbatard/rufus/releases' -UseBasicParsing | ConvertFrom-Json
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
    $toolsdir = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) "tools"
    $file = Join-Path $toolsdir "rufus$version.appx"
    Invoke-WebRequest -Uri $url32 -OutFile $file

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32 -NoCheckChocoVersion