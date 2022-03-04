$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0/media/dbvis_windows-x32_13_0.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0/media/dbvis_windows-x64_13_0.exe'
$checksum         = '24adf59683608418b941baea518b85cdb6a40684c6c73f217b8ce1b8cc44523d'
$checksumType     = 'sha256'
$checksum64       = '353b48012781c759e30ed8ec8675970dc681e592a8104aa803231fc3ffd71f10'
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
