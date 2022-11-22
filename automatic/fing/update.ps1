$ErrorActionPreference = 'Stop'
import-module au

$url32 = 'https://get.fing.com/fing-desktop-releases/win/Fing.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "fing.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	if($version -eq '2.4.1') {
		$version = '2.4.1.202012201'
	}
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
