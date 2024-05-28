$ErrorActionPreference = 'Stop'
import-module au

$release = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'

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
	$File = Join-Path $env:TEMP "FACEIT-setup-latest.exe"
	Invoke-WebRequest -Uri $release -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion.trim()
	$checksum = Get-FileHash -Path $File -Algorithm $env:ChocolateyChecksumType

	$Latest = @{ URL32 = $release; Checksum32 = $checksum; ChecksumType32 = $env:ChocolateyChecksumType; Version = $version }
	return $Latest
}

update -ChecksumFor none -NoCheckChocoVersion