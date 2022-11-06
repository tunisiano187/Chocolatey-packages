$ErrorActionPreference = 'Stop'

import-module au

function global:au_SearchReplace {
	@{
		"tools\VERIFICATION.txt" = @{
			"(^Version\s+:).*"  	= "`${1} $($Latest.Version)"
			"(^URL\s+:).*"      	= "`${1} $($Latest.URL32)"
			"(^Checksum\s+:).*" 	= "`${1} $($Latest.Checksum32)"
			"(^ChecksumType\s+:).*" = "`${1} $($Latest.ChecksumType32)"
		}
	}
}

function global:au_BeforeUpdate {
	Write-Output "Downloading jcpicker $($Latest.Version) file"
	Get-RemoteFiles -Purge -NoSuffix
	Import-Module VirusTotalAnalyzer -NoClobber -Force
	New-VirusScan -ApiKey $env:VT_APIKEY -File "tools\jcpicker.zip"
	Start-Sleep -Seconds 60
	$vt = (Get-VirusScan -ApiKey $env:VT_APIKEY -File "tools\jcpicker.zip").data.attributes.reputation
	if ( $vt -gt 5 ) {
	  Write-Error "Ignoring $($Latest.PackageName) package due to virus total results - $vt positives"
	  return 'ignore'
	}
}

function global:au_GetLatest {
	$url32 = 'https://annystudio.com/jcpicker.exe'

	$File = "$($env:TEMP)\jcpicker.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()

	$url32 = 'https://annystudio.com/jcpicker.zip'

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

 update -ChecksumFor none