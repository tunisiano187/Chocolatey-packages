$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/aria2/aria2/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      			= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 			= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 		= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Verbose 'Get files'
	$tags = Invoke-WebRequest 'https://api.github.com/repos/aria2/aria2/releases' -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets | where {$_.browser_download_url -match ".zip"} | where {$_.browser_download_url -match "32bit"}).browser_download_url
	$url64 = ($tags[0].assets | where {$_.browser_download_url -match ".zip"} | where {$_.browser_download_url -match "64bit"}).browser_download_url
	
	Write-Verbose 'Checking version'
	$version=$tags[0].name.Split(' ')[-1]

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
