$ErrorActionPreference = 'Stop'
$url32		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.5.0/gridcoin-5.4.5-win32-setup.exe'
$checksum32	    = '105c51a4eac6df7c7e218b6f77e276762e5504af8bfa695e30d4339c9d5d1709'
$checksumType32 = 'sha256'
$url64		      = 'https://github.com/gridcoin-community/Gridcoin-Research/releases/download/5.4.5.0/gridcoin-5.4.5-win64-setup.exe'
$checksum64     = 'b86bef6dde60cc9e39c6648cbe897c4bcf99064acf3e57979cbd1e591d169910'
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
