$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1/media/dbvis_windows-x32_12_1.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1/media/dbvis_windows-x64_12_1.exe'
$checksum         = '6d73e271c09fe56cba4379de5c1b34f803449734b8bee75e6b74443165d2df3a'
$checksumType     = 'sha256'
$checksum64       = '4734fedf953651a5e21b512b22ca33efbb47a43f6fba027eca0c02ed806fb51b'
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
