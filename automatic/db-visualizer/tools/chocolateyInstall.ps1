$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.1.4/media/dbvis_windows-x32_12_1_4.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.1.4/media/dbvis_windows-x64_12_1_4.exe'
$checksum         = 'f3f1e1c99fee59922cfc616a4b514a77db88ef934b33a608695428e62ec63766'
$checksumType     = 'sha256'
$checksum64       = '63c3b73caf8924c387bef11907c285aff149810b692dad16a10c9c1bfea2f88c'
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
