$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.0/ultracopier-windows-x86-3.0.0.0-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.0/ultracopier-windows-x86_64-3.0.0.0-setup.exe'
$checksum32='137d08e074b376690c67e6091b13d8217859b4d2bcb7762e0e9301f4c0f96d7a'
$checksum64='4128a1ed033b6e3500386dd3d0d2c908bbf9c4edd6dbc4b0a8b9b706549bbd42'
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

