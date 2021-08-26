$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.2/media/dbvis_windows-x32_12_1_2.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.2/media/dbvis_windows-x64_12_1_2.exe'
$checksum         = '59cb7f2a49967fc3812f79fe8053f4a27c8d15e0cf87643dd74b38a341427bf6'
$checksumType     = 'sha256'
$checksum64       = 'cfc8ef5882371ac6426bea058a0ca364344488db7719e9a04055570621b3a77b'
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
