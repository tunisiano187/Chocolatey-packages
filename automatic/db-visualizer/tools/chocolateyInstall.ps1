$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0.5/media/dbvis_windows-x32_13_0_5.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.5/media/dbvis_windows-x64_13_0_5.exe'
$checksum         = 'ba174ccb3369ec25d7b628b26ae36ee4f650b7ac34ff9db534c8991292da256b'
$checksumType     = 'sha256'
$checksum64       = '76f0925b16ef7f6d9f4f669278a8015545c610b542a5d2c43aec36dde0a39795'
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
