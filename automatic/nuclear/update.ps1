$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://api.github.com/repos/nukeop/nuclear/releases/latest'
$Owner = $releases.Split('/') | Select-Object -Last 1 -Skip 3
$repo = $releases.Split('/') | Select-Object -Last 1 -Skip 2

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(^\s*url(32)?\:\s*).*"        = "`${1}<$($Latest.URL32)>"
            "(?i)(^\s*checksum(32)?\:\s*).*"   = "`${1}$($Latest.Checksum32)"
            "(?i)(^\s*checksum\s*type\:\s*).*" = "`${1}$($Latest.ChecksumType32)"
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
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $tags = Get-GitHubRelease -OwnerName $Owner -RepositoryName $repo | Select-Object -First 1
    $url32 = $tags.assets.browser_download_url | Where-Object {$_ -match "Setup.+\.exe$"}
    $version = $tags.tag_name.Replace('v','')
    $releasenotes = $tags.html_url
    if($tags.prerelease -match "true") {
        $date = $tags.published_at.ToString("yyyyMMdd")
        $version = "$version-pre$($date)"
    }
    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $url32 -keep
    Move-Item -Path $FileVersion.TempFile -Destination "tools\$($Filename.Filename)"

    return @{ URL32 = $url32; Version = $version; Checksum32 = $FileVersion.Checksum; ChecksumType32 = $FileVersion.ChecksumType; ReleaseNotes = $releasenotes }
}

update-package -ChecksumFor none
