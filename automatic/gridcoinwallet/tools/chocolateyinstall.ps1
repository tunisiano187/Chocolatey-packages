$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.1.0/gridcoin-5.4.1-win32-setup.exe'
$checksum32	    = 'a71ce0d6fe5a5746367319d34a9506c0c5e4dda68fe025458549411e2220d77e'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.1.0/gridcoin-5.4.1-win64-setup.exe'
$checksum64     = 'ad473c7ffcb02f8e2db030f6dd2edbe0e25c353551061e805a796101d53d388d'
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
