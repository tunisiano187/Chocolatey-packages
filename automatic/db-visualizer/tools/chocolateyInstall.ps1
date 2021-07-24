$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.1/media/dbvis_windows-x32_12_1_1.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.1/media/dbvis_windows-x64_12_1_1.exe'
$checksum         = 'c6544fc606a7bbcaf5aee92611df1e2676edc77240e96bbe46a83e2521991b77'
$checksumType     = 'sha256'
$checksum64       = 'b6548c9f59b75d94747a7d10708a2bf5bd34160c8827daa71133c9d157d856e3'
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
