$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.0_stable_2025-10-23/duplicati-2.2.0.0_stable_2025-10-23-win-x64-gui.zip'
$checksum       = '3ddc3b0c10afa89dc6618fddb138d3e0521a1e75466c3399e5c07ab1e0cc3bb2'
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
