$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.4/ultracopier-windows-x86-3.0.1.4-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.4/ultracopier-windows-x86_64-3.0.1.4-setup.exe'
$checksum32='b1552b4a073f3b6f5bf6943f08cc5dc426b45608324c285e4061b8125da06e4e'
$checksum64='c877c896e25bfe58960cbe12f82f4e8c2968001e5c07049d513742e980150840'
$checksumType='sha256'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = $checksum32
  checksumType  = $checksumType
  checksum64      = $checksum64
  checksumType64  = $checksumType


  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

