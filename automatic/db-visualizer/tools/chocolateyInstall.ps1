$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.2/media/dbvis_windows-x32_12_0_2.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.2/media/dbvis_windows-x64_12_0_2.exe'
$checksum         = '993bd37fab16767a62faf214ccdd49f030fc1b3a986037a1cb4daa4a4332a3d2'
$checksumType     = 'sha256'
$checksum64       = '8b9f245ca9c13eedef02edd738c5c3404f65f72f77069705cf1a252ec2523369'
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
