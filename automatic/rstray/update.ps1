$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ltGuillaume/Redshift-Tray/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"      	= "`$1'$($Latest.VERSION)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        				= "`${1} $($Latest.URL32)"
			"(?i)(checksum:).*" 				= "`${1} $($Latest.Checksum32)"
		}
	}
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | Where-Object {$_.browser_download_url -match ".zip$"}).browser_download_url
    $version = ($url32 -split '_' | select-object -Last 1).replace('.zip','')
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
	Invoke-WebRequest -Uri $url32 -OutFile "$(Get-Location)\tools\redshift-tray.zip"
	$checksum = Get-FileHash -Path "$(Get-Location)\tools\redshift-tray.zip" -Algorithm SHA256
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ltGuillaume/Redshift-Tray/master/LICENSE" -OutFile "$(Get-Location)\tools\license.txt"
	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum.Hash }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion