$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.8/ultracopier-windows-x86-3.0.0.8-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.8/ultracopier-windows-x86_64-3.0.0.8-setup.exe'
$checksum32='3295915bd1cd0b4bfc99d1c8da820174692909081651a43341d7b1d5b80b407e'
$checksum64='c5c2cf00a5be0c7ea3611bd409c829e40f4866aeab1ba719a9588bc99d851a80'
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

