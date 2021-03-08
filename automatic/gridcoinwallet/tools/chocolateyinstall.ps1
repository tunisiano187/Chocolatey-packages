$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.2.1.0/gridcoin-5.2.1-win32-setup.exe'
$checksum32	    = '737a0595ad790e81f45687dc6dca9fa4feaf89e6c6beacbee1a9f57f0bdc0350'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.2.1.0/gridcoin-5.2.1-win64-setup.exe'
$checksum64     = 'f48cbc4c405b9efa826750bfcb9aeac671a753baea6d67300dd13fe25e98ba67'
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
