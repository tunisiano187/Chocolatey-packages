$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32            = 'https://dbvis.com/product_download/dbvis-11.0.5/media/dbvis_windows-x32_11_0_5.exe'
$url64            = 'https://dbvis.com/product_download/dbvis-11.0.5/media/dbvis_windows-x64_11_0_5.exe'
$checksum         = '613256ce35f0dd559f7d1b848ce7fd06a5edccf0fc381a34014ed6376d321278'
$checksumType     = 'sha256'
$checksum64       = '4566d1082103cd0808b6d3aecef018863fddbd7d2693cf1303213f03eab080df'
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
