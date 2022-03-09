$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-13.0.1/media/dbvis_windows-x32_13_0_1.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.1/media/dbvis_windows-x64_13_0_1.exe'
$checksum         = '9a86bfea31b0bbe5b4868287d915a928b187e89db88a00fcdc3803c450b31b81'
$checksumType     = 'sha256'
$checksum64       = '9fed914d4afa34d1dadd64f0da9eb40c04fb538449773c44bafde76dd8169487'
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
