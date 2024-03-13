$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.7.0/gridcoin-5.4.7-win32-setup.exe'
$checksum32	    = '917cff8c83dd7849be7b17542a5cf3775f73179dafca5663785ad919b7ded899'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.7.0/gridcoin-5.4.7-win64-setup.exe'
$checksum64     = '69d2424e0fe24c4ce733d6f857c2ce9d898ad1f43215003cf41885c2dec1aa51'
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
