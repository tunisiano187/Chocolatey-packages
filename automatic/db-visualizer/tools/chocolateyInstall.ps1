$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.8/media/dbvis_windows-x32_12_0_8.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.8/media/dbvis_windows-x64_12_0_8.exe'
$checksum         = 'aa7fea9a2b5bf9f9dbbc996b06f62f0e9b4a483bef057a8771241d16172d9004'
$checksumType     = 'sha256'
$checksum64       = 'e8eb4c3d391bfde0ee0a34242bdbec621783f07be518b7f7de3789cbd0eb6e13'
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
