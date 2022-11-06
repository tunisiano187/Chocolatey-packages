$ErrorActionPreference = 'Stop'
import-module au

$releases = "http://wampserver.aviatechno.net/"

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksum32Type\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]checksum64Type\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_BeforeUpdate {
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32
	New-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL32).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -Url $Latest.URL64).data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
    $url32 = "$($releases)$((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'exe'}).href)[0])"
    $url64 = $url32.replace('x86','x64')
    $version = Get-Version $url32
	#$version = $url32.split('/').split('_')[-2].replace('wampserver','')
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}
choco update -y KB2919355
update -NoCheckChocoVersion
