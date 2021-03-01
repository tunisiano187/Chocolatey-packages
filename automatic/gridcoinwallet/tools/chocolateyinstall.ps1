$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.2.0.0/gridcoin-5.2.0-win32-setup.exe'
$checksum32	    = 'e72c5388e29446d9aa2917241c428350bac87830b75d416730cd56d998c93cb2'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.2.0.0/gridcoin-5.2.0-win64-setup.exe'
$checksum64     = '796cfae88a449b1b55510e396732a922e63133e8a3a0ed2f769df54b2234a4a8'
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
