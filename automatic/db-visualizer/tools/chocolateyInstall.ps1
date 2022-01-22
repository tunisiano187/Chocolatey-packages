$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.8/media/dbvis_windows-x32_12_1_8.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.8/media/dbvis_windows-x64_12_1_8.exe'
$checksum         = '058f136d2f698865da1fb172a47750d7ccb2541e38d519db39c53c7c2bc9f007'
$checksumType     = 'sha256'
$checksum64       = '9333cce360dcdbae33d1c19f6d0e4b140c6131c16c62be8c3f6bc5d4c91588ce'
$checksumType64   = 'sha256'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url32
  url64bit        = $url64

  softwareName    = 'DbVisualizer*'

  checksum        = $checksum
  checksumType    = $checksumType
  checksum64      = $checksum64
  checksumType64  = $checksumType64

  silentArgs      = "-q"

  validExitCodes  = @(0)
}

Install-ChocolateyPackage @packageArgs
