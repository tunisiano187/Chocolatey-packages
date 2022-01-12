$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.6/media/dbvis_windows-x32_12_1_6.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.6/media/dbvis_windows-x64_12_1_6.exe'
$checksum         = '3fdc5452e8a657d417ed78d9b8befac0557103af642497be74a57c4b11d680a4'
$checksumType     = 'sha256'
$checksum64       = 'cdacdf4658361be2d0bea48aefb7750647a416ce7d7d0149d7234ee0322c2354'
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
