$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.0.0/gridcoin-5.3.0-win32-setup.exe'
$checksum32	    = 'd8e3af324430a20e43e49cbce5e02e96d9da2dfc306724fe8c638d8b48638527'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.0.0/gridcoin-5.3.0-win64-setup.exe'
$checksum64     = 'c754f665f7bb44b3d9adf970bf2127c854e20523a8cc017f583c535056355937'
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
