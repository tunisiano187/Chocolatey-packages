$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/rubberduck-vba/Rubberduck/releases/latest'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$urls = ($tags[0].assets | Where-Object {$_.browser_download_url -match "Rubberduck.Setup"} | Where-Object {$_.browser_download_url -match ".exe$"}).browser_download_url
    $url32 = $urls | Where-Object {$_ -match 'win32'}
    $version = $url32 -split 'v|/' | select-object -Last 1 -Skip 1
    foreach ($tag in $tags) {
        if($tag.tag_name -match $version) {
            if($tag.prerelease -eq $true) {
                $version = $url32.Split('/')[-1].replace('.exe','').split('u')[-1].replace('p.','')
            }
        }
    }

    return @{ URL32 = $url32; Version = $version }
}

update-package -ChecksumFor 32 -NoCheckChocoVersion