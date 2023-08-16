$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://dbvis.com/product_download/dbvis-23.2.4/media/dbvis_windows-x64_23_2_4.exe'
$checksum64       = '8d0764228ddf5c4b5f0ad0e5dc98b5e499e992880ef1ad6b6f0cae061d05a7ec'
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
