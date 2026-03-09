$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.0/ultracopier-windows-x86-3.0.2.0-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.0/ultracopier-windows-x86_64-3.0.2.0-setup.exe'
$checksum32='2284510c41a0eadfe4ae9cd71c5df7b145cca5d918ce52bdf57292002b687a78'
$checksum64='c2a6b60bdff5d6457f698e2bb73df9b786fdab733bf8c7f2d86ac01cca25eb0f'
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

