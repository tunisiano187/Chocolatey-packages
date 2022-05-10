$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.first-world.info/files/2.2.5.1/ultracopier-windows-x86-2.2.5.1-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.first-world.info/files/2.2.5.1/ultracopier-windows-x86_64-2.2.5.1-setup.exe'
$checksum32='a73f74ced221cc33b09225bf340e685c5c149bb3798ea974da5cbfa56868d981'
$checksum64='a38de6629d7014988295d929be4cc810844ea0c0dafe82e31dfdc0397f2d633b'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64      = $checksum64
  checksumType64  = 'sha256'


  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

