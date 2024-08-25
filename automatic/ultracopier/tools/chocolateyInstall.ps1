$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.7.1/ultracopier-windows-x86-2.2.7.1-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.7.1/ultracopier-windows-x86_64-2.2.7.1-setup.exe'
$checksum32='60af5dc8a8e087577c47e4da5ff8f118d4e0e6a75552673dc04b8a4dae514c1d'
$checksum64='4dda1a4d7a78dbba5a00744fce3b90b321ff46c7dc93088bbf5c24ab9fc3a6d8'

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

