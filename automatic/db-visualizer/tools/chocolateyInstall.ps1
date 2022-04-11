$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0.3/media/dbvis_windows-x32_13_0_3.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.3/media/dbvis_windows-x64_13_0_3.exe'
$checksum         = 'c25c271ca2d70af3ee0ed0e25ff20b543e532668cef1b8d790f0fa5786981f66'
$checksumType     = 'sha256'
$checksum64       = 'bdbdc40e029340f2fbf292128b516f4ae21d071e9f70f7739bfbd74b17241d76'
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
