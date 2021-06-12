$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.7/media/dbvis_windows-x32_12_0_7.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.7/media/dbvis_windows-x64_12_0_7.exe'
$checksum         = 'd15fd03b8a913a9300b731f809e76faf272d43012a3c4555ede11f4c41f01811'
$checksumType     = 'sha256'
$checksum64       = '2657a246c8b8f639766979a6ac449c6c1b78eaf0440fac276481e80afd07b7f6'
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
