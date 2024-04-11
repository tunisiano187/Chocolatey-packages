$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.8.0/gridcoin-5.4.8-win32-setup.exe'
$checksum32	    = '01d9aac21a4a34eb9c2ce9f43f659e03ebf1caf65896b6fb94a46acb583ce8e3'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.8.0/gridcoin-5.4.8-win64-setup.exe'
$checksum64     = '9f8a90f2508ff2ce85f2b21cc46ef0609bbe96c85c3fb1ae2895de9e59094cf4'
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
