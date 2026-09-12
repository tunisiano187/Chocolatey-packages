$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.4.0.101_canary_2026-09-11/duplicati-2.4.0.101_canary_2026-09-11-win-x64-gui.zip'
$checksum       = '26db64b4bc8783f2cf0a190fa3a93108f4b7a2723314ff44d6e35a900c9edf8c'
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
