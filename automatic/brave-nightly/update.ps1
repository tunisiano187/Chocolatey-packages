$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url32\s*=\s*)('.*')"		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum32\s*=\s*)('.*')"	= "`$1'$($Latest.Checksum32)'"
			"(^[$]checksumType32\s*=\s*)('.*')"	= "`$1'$($Latest.ChecksumType32)'"
		}
	}
}
function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserStandaloneSilentNightlySetup.exe'} | Select-Object -First 1).href)
	Write-Output 'Checking version'
	$version = $url32.split('/')[5].replace('v','')
	$version = "$version-nightly"
	Write-Output "Version : $version"

	$url32 = "https://github.com$($url32)";

	$Latest = @{ URL32 = $url32; Version = $version }
	return $Latest
}

update -ChecksumFor 32
