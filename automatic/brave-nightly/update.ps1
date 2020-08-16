$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
		}
		"tools\VERIFICATION.txt"      = @{
			"(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
			"(?i)(x86_64:).*"     = "`${1} $($Latest.URL64)"
			"(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
			"(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
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
	$toolsPath = Join-Path $(Get-Location) "tools"

	$url32 = "https://github.com$($url32)";
	Invoke-WebRequest -Uri $url32 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentNightlySetup32.exe")
	$url64 = "https://github.com$($url64)";
	Invoke-WebRequest -Uri $url64 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentNightlySetup.exe")

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none
