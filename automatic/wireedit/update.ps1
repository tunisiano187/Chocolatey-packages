$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://omnipacket.com/downloads"

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
    Install-Module VirusTotalAnalyzer -Force
    Import-Module VirusTotalAnalyzer -NoClobber -Force
    $vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -File $Latest.URL32).data.attributes.reputation
    if ( $vt -gt 5 ) {
        Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
        return 'ignore'
    }
  }

function global:au_GetLatest {
	$url32="https://omnipacket.com/$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.msi'} | Where-Object {$_ -match 'WireEdit'}).href)"

    $version = $url32.Split("-")[-1].replace('.msi','')

	$Latest = @{ URL32 = $url32; Version = $version }

    return $Latest
}

update -ChecksumFor 32
