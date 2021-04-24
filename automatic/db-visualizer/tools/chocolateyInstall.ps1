$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.5/media/dbvis_windows-x32_12_0_5.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.5/media/dbvis_windows-x64_12_0_5.exe'
$checksum         = '70744f2f3b7e1f00d4936b5687ead0c85cb5efe167ad5dc5c2945bddb00a5bc3'
$checksumType     = 'sha256'
$checksum64       = '4459f740c33a253f09593d1c9677edb3aa978cad2259d43d9a3588b3393de201'
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
