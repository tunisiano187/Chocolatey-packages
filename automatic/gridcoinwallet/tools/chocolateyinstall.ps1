$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.1.0/gridcoin-5.0.1-win32-setup.exe'
$checksum32	    = 'd667ce9ec34b9fd03790a1da9afc637bb3922ae085b3bcad6ac6284c5a682ea2'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.0.1.0/gridcoin-5.0.1-win64-setup.exe'
$checksum64     = '6d1e1b5efe9d130a77ebfac813837fe2aed91a3a08ef5a4984f65c2ec894411f'
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
