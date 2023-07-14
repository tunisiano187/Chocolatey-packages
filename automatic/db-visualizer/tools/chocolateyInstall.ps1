$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://dbvis.com/product_download/dbvis-23.2.3/media/dbvis_windows-x64_23_2_3.exe'
$checksum64       = 'ef034012ddf2726c3d69bd0e5a71771b82fa463445fbd6d70096358256f4d22e'
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
