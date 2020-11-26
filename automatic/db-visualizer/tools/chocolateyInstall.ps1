$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-11.0.6/media/dbvis_windows-x32_11_0_6.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-11.0.6/media/dbvis_windows-x64_11_0_6.exe'
$checksum         = '7e8be7cec3a460f956042d24937d5de20d4c61682d26cb1ed26816560e5bbb85'
$checksumType     = 'sha256'
$checksum64       = '636173bd53bb6a30a68a3050fd39827b57b4ea36714b15f0ad3a313a911d3668'
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
