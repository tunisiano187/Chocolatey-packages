$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/duplicati/duplicati/releases"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest 'https://api.github.com/repos/duplicati/duplicati/releases' -UseBasicParsing | ConvertFrom-Json
    $url32 = (($tags | Select-Object -First 1).assets | Where-Object {$_ -match '.zip'} | Where-Object {$_ -notmatch '-signatures'} | Select-Object -First 1).browser_download_url
    $version = ($tags[0].tag_name).split('v|-')[1]
    foreach ($tag in $tags) {
        if($tag.tag_name -match $version) {
            if($tag.prerelease -match "true") {
                $clnt = new-object System.Net.WebClient;
                $clnt.OpenRead("https://github.com$($installers)").Close();
                $date = $([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
                $version = "$version-pre$($date)"
            }
        }
    }

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
