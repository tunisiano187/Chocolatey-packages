$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://api.github.com/repos/microsoft/ntttcp/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url(32)?\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum(32)?\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType(32)?\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo -Latest
    $url32 = $tags.assets.browser_download_url | Where-Object {$_ -match ".exe$"} | Where-Object {$_ -notmatch "64"}
    $FileInfos = Get-FileVersion -url $url32
    Update-Metadata -key "releaseNotes" -value $tags.html_url
	$version = $tags.tag_name.Replace('v','')
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }

    return @{ URL32 = $url32; Version = $version; Checksum32 = $FileInfos.CHECKSUM; ChecksumType32 = $FileInfos.ChecksumType }
}

update -ChecksumFor none -NoCheckChocoVersion
