$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.4.0/gridcoin-5.4.4-win32-setup.exe'
$checksum32	    = '147e2fd40f041724d63368507cbd588fd02e1bd6547b311c68a4e69d876345dd'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.4.0/gridcoin-5.4.4-win64-setup.exe'
$checksum64     = 'd71351c63bf2b7ee291303f034554fdfd7c0523ec414c27f23739338e347f9ad'
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
