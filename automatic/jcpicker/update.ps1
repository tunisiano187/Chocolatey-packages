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
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = 'https://annystudio.com/jcpicker.exe'

	$page=Invoke-WebRequest -Uri "https://annystudio.com/software/colorpicker"
	$version = ($page.Links | Where-Object {$_ -match 'Download free Just'})[0].innerHTML.split(' ') | Where-Object {$_ -match "\."}

	$url32 = 'https://annystudio.com/jcpicker.zip'

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

 update -ChecksumFor none