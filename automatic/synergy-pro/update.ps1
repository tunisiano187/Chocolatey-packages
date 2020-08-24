$ErrorActionPreference = 'Stop'
import-module au

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$url32="https://binaries.symless.com/synergy/v1-core-standard/v1.11.1-stable-55ec3105/synergy_v1.11.1-stable_b145-55ec3105_windows_x86.msi"
	$url64="https://binaries.symless.com/synergy/v1-core-standard/v1.11.1-stable-55ec3105/synergy_v1.11.1-stable_b169-55ec3105_windows_x64.msi"

	$version="1.11.1"

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update