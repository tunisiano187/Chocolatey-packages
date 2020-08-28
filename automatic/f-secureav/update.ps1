$ErrorActionPreference = 'Stop'
import-module au

$url32 = 'https://download.sp.f-secure.com/SE/Retail/installer/F-SecureNetworkInstaller-AV.exe'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$File = Join-Path $env:TEMP "fsav.exe"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32 -NoCheckChocoVersion
