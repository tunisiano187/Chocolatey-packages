$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.4/ultracopier-windows-x86-3.1.0.4-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.1.0.4/ultracopier-windows-x86_64-3.1.0.4-setup.exe'
$checksum32='2e1b6c5ceb02026ca4aee6a7a167209f48f246a4d24c826cd70f8a061bfd6b5b'
$checksum64='4e1aca2d534635948ae40245308af29ed4895ffbef3f8dabf860b9635c24a93c'
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

