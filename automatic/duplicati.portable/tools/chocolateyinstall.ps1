$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.114_canary_2025-04-14/duplicati-2.1.0.114_canary_2025-04-14-win-x64-gui.zip'
$checksum       = 'cbc415451d0950b5f49950d1ed22e2d77f77d0ffde1f10dbf139fb67a972065c'
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
