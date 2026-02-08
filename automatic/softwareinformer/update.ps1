$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = "https://software-informer.informer.com/download/"

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
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url32 = "https://files.informer.com/siinst.exe"

	$versionMatches = $download_page.Content.Split("<span>") | Where-Object {$_ -match "\.[0-9][0-9][0-9][0-9]"} | Where-Object {$_ -match '(x86/x64)'}

	if (-not $versionMatches) {
		throw "Could not extract version information from page"
	}

	$version = @($versionMatches)[0].split(' ')[0].trim()

	if (-not $version -or $version -eq "") {
		throw "Could not parse version"
	}

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
