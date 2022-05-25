$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0.4/media/dbvis_windows-x32_13_0_4.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.4/media/dbvis_windows-x64_13_0_4.exe'
$checksum         = '8b9c08c8bba52343f9fd1bdbaec279c39c7d6e76811b81300881b9849c16f693'
$checksumType     = 'sha256'
$checksum64       = '40ed31667a3d88d4d322c1bdfb8a93e89b6caef89dd4be50469e6c79c37559a7'
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
