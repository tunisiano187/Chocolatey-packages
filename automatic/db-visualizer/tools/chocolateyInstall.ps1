$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://www.dbvis.com/product_download/dbvis-24.1.4/media/dbvis_windows-x64_24_1_4.exe'
$checksum64       = 'ecfe93936e3390b33a2c615a412e3a6205207eba87c8b9ef980967639e797afb'
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
