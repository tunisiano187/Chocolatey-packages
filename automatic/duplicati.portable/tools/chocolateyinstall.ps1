$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.103_canary_2024-12-21/duplicati-2.1.0.103_canary_2024-12-21-win-x64-gui.zip'
$checksum       = '8bc26d3a4d6fc7bf3efb1cc006d60b296afac52d8ee66e92532c6bd047b3688d'
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
