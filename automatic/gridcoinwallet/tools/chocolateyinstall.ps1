$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.6.0/gridcoin-5.4.6-win32-setup.exe'
$checksum32	    = 'e73e0eedebccebad4fa40b6b739d8bc33e134959f14386a7a105b353f28da2aa'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.6.0/gridcoin-5.4.6-win64-setup.exe'
$checksum64     = '68921443938df926daac89d749fd3554d0c1041343f3beebfea7faee5a70d98a'
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
