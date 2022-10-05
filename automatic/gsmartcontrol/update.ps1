$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/ashaduri/gsmartcontrol/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"      	= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      	= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	Write-Output 'Check Folder'
	$installer = (($tags[0].assets | Where-Object {$_.browser_download_url -match 'gsmartcontrol-'} | Where-Object {$_.browser_download_url -match ".exe"} | Where-Object {$_.browser_download_url -notmatch 'hotfix'} | Where-Object {$_.browser_download_url -notmatch 'sha256'}).browser_download_url | Select-Object -First 2 | Sort-Object )
	Write-Output 'Checking version'
	$version=$installer[0].split('/')[-1].split('-')[1]
	Write-Output "Version : $version"
	$url32 = $installer | Where-Object {$_ -match 'win32'}
	$url64 = $installer | Where-Object {$_ -match 'win64'}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
