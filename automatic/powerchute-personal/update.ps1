$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.se.com/ww/en/download/search/Powerchute%20personal/?docTypeGroup=3541958-Software+%26+Firmware&sortByField=Document_Date_New&keyword=Powerchute+personal'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
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
	$url32 = "https:$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_.href -match 'PCPE'} | Where-Object {$_.href -notmatch 'pdf'} | Where-Object {$_.href -match 'files'})[0].href)"
	$version = ($url32.Split('=|&') | Where-Object {$_ -match '.exe'}).replace('PCPE_','').replace('.exe','')

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
