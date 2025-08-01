$ErrorActionPreference = 'Stop'
import-module chocolatey-AU

$releases = 'https://www.samsung.com/global/download/SamsungDeXWin'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$url32 = Get-RedirectedUrl $releases
	$File = Join-Path $env:TEMP $($url32.Split('/')[-1])
	Invoke-WebRequest -Uri $url32 -OutFile $File -UseBasicParsing
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion

	if($version -eq '1.2') {
		$version = '1.20.0.2022120601'
	}
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
