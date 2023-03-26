$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.2.0/gridcoin-5.4.2-win32-setup.exe'
$checksum32	    = 'b7b925b26bd2c9a3d6eb386b09ef4f58f55f17b70aa06673541f7a09681a2a3e'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.2.0/gridcoin-5.4.2-win64-setup.exe'
$checksum64     = '56087c0cf721deb212c9dda6b0754547ced071caadd40651544204441b2945a7'
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
