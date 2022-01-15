$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.7/media/dbvis_windows-x32_12_1_7.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.7/media/dbvis_windows-x64_12_1_7.exe'
$checksum         = '7d6a499b7f6c0ae18aedd72f8b536aa3e0a33975882806a092fa4f5cfac4de83'
$checksumType     = 'sha256'
$checksum64       = '02fce3aaa3e70fa7d1f6c810c12bdaed0ba7f39a50b1fed7e23bb1a38951485d'
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
