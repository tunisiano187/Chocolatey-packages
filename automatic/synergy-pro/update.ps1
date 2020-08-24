$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://members.symless.com/synergy/download/direct?platform=windows&architecture=x"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32="$($releases)86"
	$url64="$($releases)64"

	$File = Join-Path($(Split-Path $script:MyInvocation.MyCommand.Path)) "synergy.msi"
	Invoke-WebRequest -Uri $url32 -OutFile $File
	$version=[System.Diagnostics.FileVersionInfo]::GetVersionInfo($File).FileVersion
	Write-Output "Version : $version"
	
	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update
Test-Package