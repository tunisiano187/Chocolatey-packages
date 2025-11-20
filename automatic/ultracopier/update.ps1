$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = "https://ultracopier.herman-brule.com/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Import-Module ..\..\scripts\au_extensions.psm1
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$re  = "-x86-"
	$url32 = $download_page.Content.Split('"') | Where-Object {$_ -match $re}

	$version = $url32.Split('-') | Where-Object {$_ -match '\..\.'} | Where-Object {$_ -notmatch "ultra"}
	$url64 = $url32.Replace('x86','x86_64')

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
