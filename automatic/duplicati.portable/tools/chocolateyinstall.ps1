$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.100_canary_2025-11-05/duplicati-2.2.0.100_canary_2025-11-05-win-x64-gui.zip'
$checksum       = '3cf1f0bac190e3a83c637a83e51c9dae298be4e6b60e367bd0f64f2b5ba3d199'
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
