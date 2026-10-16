$ErrorActionPreference = 'Stop'
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v44.8.0/electron-v44.8.0-win32-x64.zip'
$checksum = '1c9319bab793492715f7668e0be0e6a30bf2a8577275e40035bd33601bf6f573'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	url           = $url
	unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	checksum      = $checksum
	checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
