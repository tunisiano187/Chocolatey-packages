$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.101_canary_2025-11-20/duplicati-2.2.0.101_canary_2025-11-20-win-x64-gui.zip'
$checksum       = '2cc17928ecce3bf8c2d3bc3f7b59dcfacaee6036a262a0b73615d7e4f88f010d'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
