$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.3/media/dbvis_windows-x32_12_1_3.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.3/media/dbvis_windows-x64_12_1_3.exe'
$checksum         = 'a6ed0675dfbc0af1056b0a64fe600de84e2454c38884be658eed6beae112869a'
$checksumType     = 'sha256'
$checksum64       = '661d67798839f51a4bdc88951a5dba9de39ae2869aff92419187a6893df74ed4'
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
