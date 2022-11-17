$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://live.sysinternals.com/autoruns.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "autoruns.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$release = "https://download.sysinternals.com/files/Autoruns.zip"


	$Latest = @{ URL32 = $release; Version = $version }
	return $Latest
}

update -ChecksumFor 32
