$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.0.0/gridcoin-5.0.0-win32-setup.exe'
$checksum32	    = '1c991c2f1f84f831c52cff23251cceb94d4ec766a591f988600e9ab32d13a8f3'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.0.0/gridcoin-5.0.0-win64-setup.exe'
$checksum64     = '5214e30f7de334593322b7c8f86d9c70fc7ada7691bf0f4374341d3326673961'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName   	= $env:ChocolateyPackageName
  fileType      	= 'exe'
  url				      = $url32
  url64bit      	= $url64
  softwareName  	= 'Gridcoin Wallet'
  checksum      	= $checksum32
  checksum64		  = $checksum64
  checksumType  	= $checksumType32
  checksum64Type	= $checksumType64
  silentArgs    	= "/S"
  validExitCodes	= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
