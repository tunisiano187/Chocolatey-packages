$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.3.0/gridcoin-5.4.3-win32-setup.exe'
$checksum32	    = '9ba902af0b8836c1adde90c156c45cdb7739cadbf2a735381e39fab6cb010373'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.3.0/gridcoin-5.4.3-win64-setup.exe'
$checksum64     = 'bab2d61b0162f0be337717ba2a29f4d29bc87b262753d0f26eb98b2de62bc927'
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
