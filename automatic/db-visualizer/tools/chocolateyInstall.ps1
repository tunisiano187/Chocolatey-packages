$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.6/media/dbvis_windows-x32_12_0_6.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.6/media/dbvis_windows-x64_12_0_6.exe'
$checksum         = '7d6449f05c933042035410fa89b9122f434a0a697594e96080dd19e69229bd2a'
$checksumType     = 'sha256'
$checksum64       = '2c5dd50522825f7271c74d1fffb7c9dd513f52d12cfb805f4909a8e451a925ea'
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
