$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://www.winedt.com/download.html"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $link = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'})
	$url32="https://www.winedt.com/$($link.href)"

    $version = (Get-Version $link.outerHTML).Version

	$Latest = @{ URL32 = $url32; Version = $version }

    return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
