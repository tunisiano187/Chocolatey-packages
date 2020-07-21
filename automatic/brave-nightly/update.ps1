import-module au

$releases = 'https://github.com/brave/brave-browser/releases'

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$url32 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserNightlySetup32.exe'}).href)[0]
	$url64 = $(((((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links)) | Where-Object {$_ -match 'BraveBrowserNightlySetup.exe'}).href)[0]
	Write-Output 'Checking version'
	$version = $url32.split('/')[5].replace('v','')
	Write-Output "Version : $version"
	$toolsPath = Join-Path $(Get-Location) "tools"

	$url32 = "https://github.com$($url32)";
	Invoke-WebRequest -Uri $url32 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentSetup32.exe")
	$url64 = "https://github.com$($url64)";
	Invoke-WebRequest -Uri $url64 -OutFile $(Join-Path $toolsPath "BraveBrowserSilentSetup.exe")

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -ChecksumFor none