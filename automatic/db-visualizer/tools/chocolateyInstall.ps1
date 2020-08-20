$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://www.dbvis.com/product_download/dbvis-11.0.4/media/dbvis_windows-x32_11_0_4.exe'
$url64            = 'https://www.dbvis.com/product_download/dbvis-11.0.4/media/dbvis_windows-x64_11_0_4.exe'
$checksum         = 'b2b14ef67689f206f94b6320752a8a4fe389cc4f5cf8f074aee6d1b4aa2c4467'
$checksumType     = 'sha256'
$checksum64       = '813bb5499ad0368b7f4eae08d637911b1da594d8c92d2024da57605ad286bfa7'
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
