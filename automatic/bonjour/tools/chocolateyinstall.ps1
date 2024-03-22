$ErrorActionPreference = 'Stop';

$url              = 'https://www.apple.com/itunes/download/win32'
$checksum         = 'cd6891afada9f940bc551a215a6c40f51a93b140026375bd30b1ee686dc73bd2'
$checksumType     = 'SHA256'

$url64            = 'https://www.apple.com/itunes/download/win64'
$checksum64       = '541c30b2d72705afe75649f97e3daf677b8576e6e73d6f78f7265a0ded61011f'
$checksumType64   = 'SHA256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType		= "msi"

  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType

  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= $checksumType64

  silentArgs	= "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs
