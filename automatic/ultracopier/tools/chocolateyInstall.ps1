$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.3/ultracopier-windows-x86-3.1.0.3-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.3/ultracopier-windows-x86_64-3.1.0.3-setup.exe'
$checksum32='bbf9528b1eb7d067fadb16d8724d0558b5c7dd3af77fcad1fbeca391422f0181'
$checksum64='997de99862183b6be53d6947547a7249d895855da3cf4ffade5370efd69d3d97'
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

