$ErrorActionPreference = 'Stop'
import-module au

$releases 		= 'https://www.bkool.com/en/download/windows'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}

function global:au_GetLatest {
	$url32 = $releases
	$File = Join-Path $env:TEMP "bkool.exe"
	(new-object System.Net.WebClient).DownloadFile($url32,$File)
	$version=$(Get-Command $File).FileVersionInfo.ProductVersion.trim()

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

Test-Package
update
