$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.5/ultracopier-windows-x86-3.0.1.5-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.5/ultracopier-windows-x86_64-3.0.1.5-setup.exe'
$checksum32='225fbadc39fd9e44b7bf09fca41f03ffafe7093dc3ec88c1c624c876fcca38de'
$checksum64='357a06c9280b481c83a0bd9fb59b75334ec4321f852d60f8cbdefd87147692db'
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

