$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.2/ultracopier-windows-x86-3.0.1.2-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.2/ultracopier-windows-x86_64-3.0.1.2-setup.exe'
$checksum32='3a6a294a9136e3a6cee2af88d28a9ecbe3ef3edf29c7f5b0609ab8997c7d0c81'
$checksum64='5da27c4669541ace69c8a1dbfa7ca808dd114ca1c05e1f3a05e28e47a519eee1'
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

