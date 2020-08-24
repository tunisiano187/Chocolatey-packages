$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://members.symless.com/synergy/download/direct?platform=windows&architecture=x"

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(Url\s*=\s*)('.*')"        	= "`$1'$($Latest.Url32)'"
			"(Checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(ChecksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(Url64bit\s*=\s*)('.*')"       = "`$1'$($Latest.Url64)'"
			"(Checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(ChecksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$url32="https://binaries.symless.com/synergy/v1-core-standard/v1.11.1-stable-55ec3105/synergy_v1.11.1-stable_b145-55ec3105_windows_x86.msi"
	$url64="https://binaries.symless.com/synergy/v1-core-standard/v1.11.1-stable-55ec3105/synergy_v1.11.1-stable_b169-55ec3105_windows_x64.msi"

	$version=""
	Write-Output "Version : $version"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
Test-Package