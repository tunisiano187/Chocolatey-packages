$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.13/ultracopier-windows-x86-2.2.4.13-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.13/ultracopier-windows-x86_64-2.2.4.13-setup.exe'
$checksum32='ffbe4a4552e0d7fa8a3528ad5dcb985a7ddf1b5e1424eee365b1fafe9575df75'
$checksum64='d84f9d2b31711bad68516d295a788b2452c4e9ab97cbce60e1f090e75c12d68a'

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

