$ErrorActionPreference = 'Stop'
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v44.6.0/electron-v44.6.0-win32-x64.zip'
$checksum = '04d6071f8deca081044e1398f96f65e4c1550ffdb3f882504cd78528d821d422'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	url           = $url
	unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	checksum      = $checksum
	checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
