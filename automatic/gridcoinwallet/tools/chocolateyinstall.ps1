$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.3.0/gridcoin-5.3.3-win32-setup.exe'
$checksum32	    = 'cf482e9b100f83fb2faf0cc59c4bd0b77a8c627a320953944a107e0e64730d83'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.3.0/gridcoin-5.3.3-win64-setup.exe'
$checksum64     = 'e403c23152c5a07bf477dd291c9ed0b48b6cfd2d71eb6a86b134ae2c27f2d244'
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
