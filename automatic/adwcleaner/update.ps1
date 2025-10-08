$ErrorActionPreference = 'Stop'
import-module Chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$release = 'https://downloads.malwarebytes.com/file/adwcleaner'

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
	$File = Join-Path $env:TEMP $($release -split "/" | Select-Object -Last 1)
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$checksum = (Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType).Hash
	Remove-Item $File -Force
	Remove-Item "tools/*.exe" -ErrorAction SilentlyContinue

	$Latest = @{ URL32 = $release; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion