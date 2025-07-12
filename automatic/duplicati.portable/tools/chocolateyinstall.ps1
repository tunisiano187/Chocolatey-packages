$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.124_canary_2025-07-11/duplicati-2.1.0.124_canary_2025-07-11-win-x64-gui.zip'
$checksum       = '1281ec99bc40e4dc2d5f8bdc501088b0b85a62bbaafa016f2ff9f4872457e9f9'
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
