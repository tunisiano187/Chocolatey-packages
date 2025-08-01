$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

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

	$version = $($download_page.Content.Split("<span>") | Where-Object {$_ -match "\.[0-9][0-9][0-9][0-9]"} | Where-Object {$_ -match '(x86/x64)'}).split(' ')[0].trim()

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
