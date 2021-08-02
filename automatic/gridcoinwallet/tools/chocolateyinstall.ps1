$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.2.0/gridcoin-5.3.2-win32-setup.exe'
$checksum32	    = 'a68783c4298ffa88ab91690b911528d0136482517cab7edff23f4a1333d2060b'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.3.2.0/gridcoin-5.3.2-win64-setup.exe'
$checksum64     = '7839d78e2826a318aa95c113bc525429e5a72a0205ad8a3e3308473de061f114'
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
