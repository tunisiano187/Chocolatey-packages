$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.7/ultracopier-windows-x86-3.1.0.7-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.7/ultracopier-windows-x86_64-3.1.0.7-setup.exe'
$checksum32='1d5856e37b45f8d88e3087f562ee5c9e129f254dc6a0e9ec94637c36a7b852d0'
$checksum64='5448104fcbc6731dfd270b351e22a1d034b1c09ee083804776fcfa1b1340e95f'
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

