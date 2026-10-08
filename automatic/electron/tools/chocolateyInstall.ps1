$ErrorActionPreference = 'Stop'
# Electron stopped publishing a win32-ia32 (32-bit Windows) build as of v44 -- 64-bit only now.
$url = 'https://github.com/electron/electron/releases/download/v44.7.0/electron-v44.7.0-win32-x64.zip'
$checksum = 'eee30dc8fa1f5ea95490e59f44e46ea68dd24c6e93d22facf70fe5c2d4c2665c'
$checksumType = 'sha256'

$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	url           = $url
	unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
	checksum      = $checksum
	checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
