$ErrorActionPreference = 'Stop'
import-module chocolatey-AU
Import-Module ..\..\scripts\au_extensions.psm1

$releases = 'https://www.softwareok.com/Download/NewFileTime.zip'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]Checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]Checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]ChecksumExtra\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumExtra)'"
		}
	}
}

function global:au_AfterUpdate($Package) {
	Invoke-VirusTotalScan $Package
}

function global:au_GetLatest {
	$LocalTempPath = Join-Path -Path $env:TEMP -ChildPath "chocolatey\NewFileTime\"
	$LocalFile = Join-Path -Path $LocalTempPath -ChildPath "NewFileTime.zip"
	New-Item -ItemType Directory -Path $LocalTempPath -Force
	Invoke-WebRequest -Uri $releases -OutFile $LocalFile
	Expand-Archive -Path $LocalFile -DestinationPath $LocalTempPath -Force
	$File = Join-Path -Path $LocalTempPath -ChildPath "NewFileTime.exe"
	$version=([System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion).replace(', ','.')
	$url32 = $releases
	$checksumType = 'sha256'
	$checksum32 = (Get-FileHash -Path $LocalFile -Algorithm $checksumType).Hash
	Invoke-WebRequest -Uri "https://www.softwareok.com/Download/NewFileTime_x64.zip" -OutFile $LocalFile
	$checksum64 = (Get-FileHash -Path $LocalFile -Algorithm $checksumType).Hash
	Invoke-WebRequest -Uri "https://www.softwareok.com/Download/NewFileTime_Unicode.zip" -OutFile $LocalFile
	$checksumExtra = (Get-FileHash -Path $LocalFile -Algorithm $checksumType).Hash

	$Latest = @{ URL32 = $url32; Version = $version; Checksum32 = $checksum32; Checksum64 = $checksum64; ChecksumExtra = $checksumExtra }
	return $Latest
}

update -ChecksumFor none
