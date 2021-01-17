$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')"	= "`$1'$($Latest.Version)'"
			"(^[$]url32\s*=\s*)('.*')"		= "`$1'$($Latest.URL32)'"
			"(^[$]url64\s*=\s*)('.*')"		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum32\s*=\s*)('.*')"	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksum64\s*=\s*)('.*')"	= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType32)'"
			"(^[$]checksumType64\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}
function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserSilentNightlySetup32.exe'} | Select-Object -First 1).href)
	$url64 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserSilentNightlySetup.exe'} | Select-Object -First 1).href)
	Write-Output 'Checking version'
	$version = $url32.split('/')[5].replace('v','')
	$version = "$version-nightly"
	Write-Output "Version : $version"

	$url32 = "https://github.com$($url32)";
	$url64 = "https://github.com$($url64)";

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update