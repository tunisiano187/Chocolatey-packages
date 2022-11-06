$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://www.ebswift.com/scite-text-editor-installer.html'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
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
	Write-Output 'Check Folder'
	$installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match 'scite'} | Where-Object {$_ -match ".msi"} | Select-Object -First 2 | Sort-Object ).href
	Write-Output 'Checking version'
	$version=$($installer[1]).split('/')[-1].split('-')[-1].replace('x86.msi','')
	Write-Output "Version : $version"
	$url32 = "https://www.ebswift.com$($installer[1])";
	$url64 = "https://www.ebswift.com$($installer[0])";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion
