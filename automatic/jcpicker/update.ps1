$ErrorActionPreference = 'Stop'

import-module chocolatey-AU

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
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://annystudio.com/jcpicker.exe'

	$page=Invoke-WebRequest -Uri "https://annystudio.com/software/colorpicker" -UseBasicParsing
	$version = ($page.Links | Where-Object {$_.href -match "jcpicker.exe"})[0].outerHTML.split(' ') | Where-Object {$_ -match "[0-9]\."}

	$url32 = 'https://annystudio.com/jcpicker.zip'

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

 update -ChecksumFor none
