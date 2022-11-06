$ErrorActionPreference = 'Stop'
import-module au

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

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

	$url32 = "https://files.informer.com/siinst.exe"

	$version = $($download_page.Content.Split("<span>") | Where-Object {$_ -match "\.[0-9][0-9][0-9][0-9]"} | Where-Object {$_ -match '(x86/x64)'}).split(' ')[0].trim()

	$Latest = @{ URL32 = $url32; Version = $version }
    return $Latest
}

update -ChecksumFor 32
