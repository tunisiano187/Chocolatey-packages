$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.9.105_canary_2024-08-29/duplicati-2.0.9.105_canary_2024-08-29-win-x64-gui.zip'
$checksum       = '0afe9d9928a1c0a876684d91c538c6cc33dc1b9fa9d05591966e91e6fd553aa2'
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
