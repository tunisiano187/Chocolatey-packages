$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.1.0/gridcoin-5.3.1-win32-setup.exe'
$checksum32	    = '9a81d3916f02b2902bc334d2de5978b8f7d0432779f4c76bee72fa2a0467e328'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.1.0/gridcoin-5.3.1-win64-setup.exe'
$checksum64     = '3b2eae2c3a0cc2eaf869795cdd69426f3817ec30f22f4d321365a2833100d4c8'
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
