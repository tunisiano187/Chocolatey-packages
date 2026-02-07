$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.2.0.104_canary_2026-02-06/duplicati-2.2.0.104_canary_2026-02-06-win-x64-gui.zip'
$checksum       = 'f7b08480149e88d67c1ee52df7efe734de3f8043e0ee759ee2dc62a1cba1709f'
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
