$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.5/ultracopier-windows-x86-3.1.0.5-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.5/ultracopier-windows-x86_64-3.1.0.5-setup.exe'
$checksum32='bed02a05f1ce5a1323c4d17f816c69e9f2748b69f26c919b308731d167ad3909'
$checksum64='f1437e440180de288c1ae4be2c9efd4f1a74a95803d47943be77e41fa5b7fe57'
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

