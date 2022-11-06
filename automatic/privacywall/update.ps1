$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://cdn.privacywall.org/pro/PrivacyWallFirewallProSetup.exe'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
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
    $url32 = $releases
    $File = Join-Path $env:TEMP "privacywall.exe"

    Invoke-WebRequest -Uri $url32 -OutFile $File

    $version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

    return @{ URL32 = $url32; Version = $version }
}

update -ChecksumFor 32