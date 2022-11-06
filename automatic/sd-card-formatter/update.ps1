$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.sdcard.org/downloads/formatter/eula_windows/index.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
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
	$url32 = "https://www.sdcard.org$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object  {$_ -match 'Accept'} | Where-Object {$_.href -match '.zip'}).href.replace('./',''))"
	$File = "$env:TEMP/sdc.zip"
	Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	Expand-Archive $File -DestinationPath $env:TEMP\sdc -Force
	$version = $(Get-ChildItem -Path $env:TEMP\sdc -Filter *.exe -Recurse)[0].Name.split(' ')[3]

	return @{ URL32 = $url32
		Version = $version
	}
}

update -ChecksumFor 32
