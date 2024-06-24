$ErrorActionPreference = 'Stop'
import-module au

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

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $link = ($page.Links | Where-Object {$_.outerHTML -match "Server and client"} | Select-Object -First 1)
	$url32="https://www.winflector.com/$($link.href)"

    . ..\..\scripts\Get-FileVersion.ps1
    $FileVersion = Get-FileVersion $url32

	$Latest = @{ URL32 = $url32; Version = $FileVersion.Version; Checksum32 = $FileVersion.CHECKSUM; ChecksumType32 = $FileVersion.ChecksumType }

    return $Latest
}

update -ChecksumFor none
