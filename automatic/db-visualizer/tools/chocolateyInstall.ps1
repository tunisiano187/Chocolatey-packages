$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://www.dbvis.com/product_download/dbvis-24.1.5/media/dbvis_windows-x64_24_1_5.exe'
$checksum64       = '6a63689ab0c828699eef249a9e75d20625c7538a494f93fce64e1bd199f1472c'
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
