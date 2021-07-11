$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.9/media/dbvis_windows-x32_12_0_9.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.9/media/dbvis_windows-x64_12_0_9.exe'
$checksum         = 'c720c5acb5ddf7e879d2099dacedfd4229d5ac4de73a889c26b60b19c4e6f9d4'
$checksumType     = 'sha256'
$checksum64       = '6258a77fa959885d1062f428b50c552f4c3f62f6f5caaac470c161d44591ccb5'
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
