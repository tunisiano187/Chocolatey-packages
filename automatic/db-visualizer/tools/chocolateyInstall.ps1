$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0/media/dbvis_windows-x32_12_0.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0/media/dbvis_windows-x64_12_0.exe'
$checksum         = '60c82561537d9efe3e833460cf0bdf10b0c67faf921421367f21f69f1e91f01c'
$checksumType     = 'sha256'
$checksum64       = '08edf18e92366112365589a07c33e0df27a95299a9ae58419c45c2d561359e13'
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
