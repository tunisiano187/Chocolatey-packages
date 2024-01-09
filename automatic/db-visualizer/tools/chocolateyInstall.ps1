$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://www.dbvis.com/product_download/dbvis-24.1/media/dbvis_windows-x64_24_1.exe'
$checksum64       = 'fd9b8c011e449cf6f73950c7e76f6fbb956ca4dba16d8ab443c756fb60a86299'
$checksumType64   = 'sha256'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url64

  softwareName    = 'DbVisualizer*'

  checksum        = $checksum64
  checksumType    = $checksumType64

  silentArgs      = "-q"

  validExitCodes  = @(0)
}

Install-ChocolateyPackage @packageArgs
