$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://github.com/GPUOpen-Tools/compressonator/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	$url64 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Where-Object {$_ -match 'CLI'} | Select-Object -First 1
    $version = ($tags.tag_name).replace('V','')


    return @{ URL64 = $url64; Version = $version }
}

update-package -ChecksumFor 64
