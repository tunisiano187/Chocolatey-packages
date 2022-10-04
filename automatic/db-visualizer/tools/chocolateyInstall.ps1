$ErrorActionPreference = 'Stop'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64            = 'https://dbvis.com/product_download/dbvis-13.0.5/media/dbvis_windows-x64_13_0_5.exe'
$checksum64       = '76f0925b16ef7f6d9f4f669278a8015545c610b542a5d2c43aec36dde0a39795'
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
