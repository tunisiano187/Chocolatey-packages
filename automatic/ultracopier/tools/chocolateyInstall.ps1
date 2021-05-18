$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.10/ultracopier-windows-x86-2.2.4.10-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.10/ultracopier-windows-x86_64-2.2.4.10-setup.exe'
$checksum32='88b1c93161ffbb5f824f948637017f1fe82d4912c2f91093ee51700c52c770ba'
$checksum64='0db948c724d2cdd2f5c32ee061f4969eb97a074a41b32192fd791cbb15866dd1'

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

