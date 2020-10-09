$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.2.0/gridcoin-5.0.2-win32-setup.exe'
$checksum32	    = '560acf1eb378c692c7efa5454d197bcc22bf4906bf9299065c52d7a27d7b1ca8'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.2.0/gridcoin-5.0.2-win64-setup.exe'
$checksum64     = 'e35ddbbb24a6eb38b26239506dfc472adceeb39260673a31ce208d95cd9bc58f'
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
