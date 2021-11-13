$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.5/media/dbvis_windows-x32_12_1_5.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.5/media/dbvis_windows-x64_12_1_5.exe'
$checksum         = '058fa6755707065de60e10d6c1dd1158b04591d7a1532215a7cae4d641d25441'
$checksumType     = 'sha256'
$checksum64       = 'c78e00b7df7ca40e47e4f30202238b70af416ad4bd5d94d1269b9e1ab40c9fa8'
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
