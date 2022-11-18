$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://ultracopier-fr.first-world.info/telecharger-toutes-les-versions.html"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$re  = "ultracopier-windows-x86"
	$url = $download_page.links | Where-Object href -match $re | Select-Object -First 2 -expand href

	$version = Get-Version $url[0]
	#$version = $url[0] -split '-' | Select-Object -Last 1 -Skip 1
	$url32 = $url[0].replace('http:','https:')
    $url64 = $url[1].replace('http:','https:')

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
