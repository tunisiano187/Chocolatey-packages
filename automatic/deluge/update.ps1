$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://ftp.osuosl.org/pub/deluge/windows/?C=M;O=D"
$release = "https://ftp.osuosl.org/pub/deluge/windows/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
    $webpage = Invoke-WebRequest -Uri $releases -UseBasicParsing
	$Files = $webpage.Links | Where-Object { $_.href -match '.exe$'} | Where-Object { $_.href -notmatch 'lt2'} | Select-Object -First 2
    $url32 = "$($release)$($Files.href | Where-Object {$_ -match "win32"})"
    $url64 = "$($release)$($Files.href | Where-Object {$_ -match "win64"})"

    $version = $url32.Split('-')[1]

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
