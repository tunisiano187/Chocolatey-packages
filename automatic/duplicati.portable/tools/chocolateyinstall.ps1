$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.110_canary_2025-02-28/duplicati-2.1.0.110_canary_2025-02-28-win-x64-gui.zip'
$checksum       = '61bc57437f1d816c60925de03a1f2e971e88c31ad4dd5338ec5c54ffe90b029b'
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
