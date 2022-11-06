$ErrorActionPreference = 'Stop'
import-module au

$releases = 'http://www.chrysocome.net/dd'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
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
	Write-Verbose 'Get files'
	$url = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match '.zip'} | Where-Object {$_.href -notmatch '.src'} | Where-Object {$_.href -match '0.5'}| Select-Object -First 1).href
	Write-Verbose 'Checking version'
	$version = $url.Split('-')[-1].replace('.zip','').replace('beta','-beta')
	Write-Verbose "Version : $version"
	$url32 = "http://www.chrysocome.net/$($url)";

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
