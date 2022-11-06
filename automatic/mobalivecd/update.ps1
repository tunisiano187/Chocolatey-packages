$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.mobatek.net/labs_mobalivecd.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
		'tools/chocolateyUninstall.ps1' = @{
			"(^[$]File\s*=\s*)('.*')"      		= "`$1'$($Latest.File)'"
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
	$url32 = "https://www.mobatek.net$(((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'} | Sort-Object | Where-Object {$_.href -notmatch 'Sources'}).href)"
	$version=$url32.split('/')[-1].split('v')[-1].replace('.exe','')
	if($version -eq '2.1') { $version = '2.1.0.20200909'}
	$File	= $url32.Split('/')[-1]

	$Latest = @{ URL32 = $url32; File = $File; Version = $version }
	return $Latest
}

update -ChecksumFor 32
