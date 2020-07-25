$url32		      = ''
$checksum32	    = ''
$checksumType32 = ''
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/4.0.6.0/gridcoin-4.0.6-win64-setup.exe'
$checksum64     = ''
$checksumType64 = ''

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