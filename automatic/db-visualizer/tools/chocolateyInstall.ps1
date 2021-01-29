$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.1/media/dbvis_windows-x32_12_0_1.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.1/media/dbvis_windows-x64_12_0_1.exe'
$checksum         = '3fb91f52895748ce5b016f7b19ccdbe5e674c293f357e83a3e51ca8e6a6db2fa'
$checksumType     = 'sha256'
$checksum64       = '2e3189c7731b53f76a63f9c1114a3e580927244e522df59433824c19d40aa015'
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
