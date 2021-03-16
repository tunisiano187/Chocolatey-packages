$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-12.0.4/media/dbvis_windows-x32_12_0_4.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-12.0.4/media/dbvis_windows-x64_12_0_4.exe'
$checksum         = '17d8dbb7dc6205345d1e62307433fee9d40d52edaa863c68fd515f7beabbaef9'
$checksumType     = 'sha256'
$checksum64       = '40e63c4a0e43f8677c1c33f466832c084617972b4d661cbf78a43ce1732935d6'
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
