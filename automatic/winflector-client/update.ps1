$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
. ..\..\scripts\Get-FileVersion.ps1

$releases = "https://www.winflector.com/english/download.html"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_BeforeUpdate {
    # Download the installer via Invoke-WebRequest (in Get-FileVersion) and keep it so
    # Invoke-VirusTotalScan can submit it directly without calling Get-RemoteFiles.
    # Get-RemoteFiles uses WebClient.DownloadFile, which follows the store URL's redirect
    # to 567.com and then tries to create 'tools\567.com\store\free-version\index\id\567'
    # as the local path — a DirectoryNotFoundException because the intermediate dirs
    # don't exist (CHO-437 fixed ChecksumFor but not this code path).
    if (-not (Test-Path "tools")) { New-Item -ItemType Directory -Path "tools" | Out-Null }
    $FileVersion = Get-FileVersion $Latest.URL32 -keep
    Move-Item -Path $FileVersion.TempFile -Destination "tools\wfclsetup.exe" -Force
    $Latest.Checksum32     = $FileVersion.Checksum
    $Latest.ChecksumType32 = $FileVersion.ChecksumType
    $Latest.FileName32     = 'wfclsetup.exe'
}

function global:au_AfterUpdate($Package) {
    . ..\..\scripts\Invoke-VirusTotalScan.ps1
    Invoke-VirusTotalScan $Package
    # Delete the locally-cached installer: this package downloads at install time
    # and must not bundle the binary in the nupkg.
    Remove-Item -Path "tools\wfclsetup.exe" -Force -ErrorAction Ignore
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $link = ($page.Links | Where-Object {$_.outerHTML -match "Client for Windows"} | Select-Object -First 1)
    $url32 = "https://www.winflector.com/$($link.href)"

    $regexPattern = 'Client for Windows \((\d+(\.\d+)*)'
    $versionMatch = $page.Content | Select-String -Pattern $regexPattern -AllMatches
    $version = $versionMatch.Matches[0].Groups[1].Value

    return @{
        URL32   = $url32
        Version = $version
    }
}

update -ChecksumFor none
