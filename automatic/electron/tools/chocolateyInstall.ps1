$ErrorActionPreference = 'Stop'
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v45.1.0/electron-v45.1.0-win32-x64.zip'
$checksum = '55eaba17abff7b5bba6c3bbc85068967379024fe742fe9c7fdba9118922ccbe2'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	url           = $url
	unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	checksum      = $checksum
	checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
