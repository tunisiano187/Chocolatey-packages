$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/nukeop/nuclear/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(url64bit\s*=\s*').*(')"           = "`${1}$($Latest.URL64)`${2}"
            "(checksum64\s*=\s*').*(')"         = "`${1}$($Latest.Checksum64)`${2}"
            "(checksumType64\s*=\s*').*(')"     = "`${1}$($Latest.ChecksumType64)`${2}"
          }
    }
}

function global:au_BeforeUpdate($Package) {
    $licenseData = "https://raw.githubusercontent.com/nukeop/nuclear/master/LICENSE"
    $licenseFile = "$PSScriptRoot\legal\LICENSE.txt"
    if (Test-Path $licenseFile) { Remove-Item -Force $licenseFile }

    Invoke-WebRequest -Uri $licenseData -UseBasicParsing -OutFile "$licenseFile"
    $Latest.LicenseUrl = $licenseData
}

function global:au_AfterUpdate($Package) {
    Update-Metadata -key "licenseUrl" -value $Latest.LicenseUrl
    Update-Metadata -key "releaseNotes" -value $Latest.ReleaseNotes
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | Select-Object -First 1
    $url64 = $tags.assets.browser_download_url | Where-Object {$_ -match "setup\.exe$"} | Select-Object -First 1

    if (-not $url64) {
        throw "Could not find *setup.exe download link in $Owner/$repo release"
    }
    $version = $tags.tag_name -replace '^.*@|^v'
    $releasenotes = $tags.html_url
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $url64

    return @{ URL64 = $url64; Version = $version; Checksum64 = $FileVersion.Checksum; ChecksumType64 = $FileVersion.ChecksumType; ReleaseNotes = $releasenotes }
}

update -ChecksumFor none
