$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://api.github.com/repos/electron/electron/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
			"(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$tags = Invoke-WebRequest $releases -UseBasicParsing | ConvertFrom-Json
	$url32 = ($tags[0].assets).browser_download_url | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-ia32.zip'}
	$url64 = ($tags[0].assets).browser_download_url | Where-Object {$_ -match 'electron-'} | Where-Object {$_ -match 'win32-x64.zip'}
	Write-Output 'Checking version'
	
	$version = Get-Version $url64
	Write-Output "Version : $version"
	
	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update
