$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.first-world.info/files/2.2.6.0/ultracopier-windows-x86-2.2.6.0-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.first-world.info/files/2.2.6.0/ultracopier-windows-x86_64-2.2.6.0-setup.exe'
$checksum32='75845668859f4782a1cd66222d33a967e12598cd103fffbeed16c7eb38667f42'
$checksum64='1d1cf0fcc85dcb736765165414a3f95a667ef2399fc79a31b4c9025e639a8a8e'

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

