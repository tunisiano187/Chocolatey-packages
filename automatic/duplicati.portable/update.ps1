$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://github.com/duplicati/duplicati/releases/latest"

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
    if($tags[0].tag_name -match $version) {
        if($tags[0].prerelease -match "true") {
            $clnt = new-object System.Net.WebClient;
            $clnt.OpenRead($url32).Close();
            $date = $([datetime]$clnt.ResponseHeaders["Last-Modified"];).ToString("yyyyMMdd")
            $version = "$version-pre$($date)"
        }
    }

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
