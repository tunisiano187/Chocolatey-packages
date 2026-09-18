$ErrorActionPreference = 'Stop'
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v44.4.2/electron-v44.4.2-win32-x64.zip'
$checksum = '6aae435b6cd5c0eedf9fd38824bae4045ffdaecd029f0b8c8328bac3f5b71f03'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	url           = $url
	unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	checksum      = $checksum
	checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
