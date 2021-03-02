$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.3/media/dbvis_windows-x32_12_0_3.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.3/media/dbvis_windows-x64_12_0_3.exe'
$checksum         = 'c4d2aa6862f86287e6bb2fecf989809cae18db6fa6cf7c3b5714ca3446b24f43'
$checksumType     = 'sha256'
$checksum64       = '47105e665103261d6e50c3b18f3cf35521a31f179778fed0e74a328c9795ac16'
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
