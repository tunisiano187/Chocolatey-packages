$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.105_canary_2026-10-24/duplicati-2.4.0.105_canary_2026-10-24-win-x64-gui.zip'
$checksum       = 'c667129654b16b8acfbaf6a6fc9e08bb7eeae1836ee100dde57ee53d5cfa1c5e'
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
