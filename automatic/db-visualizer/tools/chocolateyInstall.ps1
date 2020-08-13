$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://www.dbvis.com/product_download/dbvis-10.0.25/media/dbvis_windows-x32_10_0_25.exe'
$url64            = 'https://www.dbvis.com/product_download/dbvis-10.0.25/media/dbvis_windows-x64_10_0_25.exe'
$checksum         = ''
$checksumType     = ''
$checksum64       = ''
$checksumType64   = ''

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url
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