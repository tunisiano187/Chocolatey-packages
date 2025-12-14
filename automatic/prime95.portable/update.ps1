$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.mersenne.org/download/'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_AfterUpdate($Package) {
	. ..\..\scripts\Invoke-VirusTotalScan.ps1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url32 = $page.Links.href | Where-Object {$_ -match '.win32.zip$'} | Select-Object -First 1
    $url64 = $page.Links.href | Where-Object {$_ -match '.win64.zip$'} | Select-Object -First 1
    $bugtracker = "https://www.mersenne.org/download/$($page.Links.href | Where-Object {$_ -match 'whatsnew'} | Select-Object -First 1)"
    Update-Metadata -key "releaseNotes" -value $bugtracker
    $version = ($url32.split('/')[-2])

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -NoCheckUrl
