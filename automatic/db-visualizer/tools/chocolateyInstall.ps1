$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0.2/media/dbvis_windows-x32_13_0_2.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.2/media/dbvis_windows-x64_13_0_2.exe'
$checksum         = 'b13b90fcad74680a87936b2960daa5ee1066e408065dc361648ae3d402c2b39c'
$checksumType     = 'sha256'
$checksum64       = '13d15c3d6bb1c81cd6629597924dfae2d50a7b07e2ff61552007ac214d47bb14'
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
