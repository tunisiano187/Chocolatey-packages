$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://static.idriveonlinebackup.com/downloads/version_win.js'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
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
	$url32 = (Invoke-WebRequest -Uri $releases -UseBasicParsing).content.split("'") | Where-Object {$_ -match 'exe'} | Select-Object -First 1

	$version = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).content.split('"') | Where-Object {$_ -match 'Version '} | Select-Object -First 1).split(' ') | Select-Object -Last 1

	$Latest = @{ URL32 = $url32; Version = $version.trim() }
	return $Latest
}

update -ChecksumFor 32
