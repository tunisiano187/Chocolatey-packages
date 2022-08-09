$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.0.0/gridcoin-5.4.0-win32-setup.exe'
$checksum32	    = '456517c193a9ff7e663d5eb890e3986310102cab45cabc01f63be53d99b92e88'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.0.0/gridcoin-5.4.0-win64-setup.exe'
$checksum64     = 'a6b6bf65b227cc984ce6452daeba33f7c4e2893b9fc19f541993b43afebc979f'
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
