$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.12/ultracopier-windows-x86-2.2.4.12-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.12/ultracopier-windows-x86_64-2.2.4.12-setup.exe'
$checksum32='39747dfd824737b35d86655b43f352a8aeb0ba991b289a5851f461b7978f63b6'
$checksum64='542e9f43873ea6dca02a71d8ca64e6d152e2c62c56d120a22dc75490e8414c45'

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

