$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.120_canary_2025-06-24/duplicati-2.1.0.120_canary_2025-06-24-win-x64-gui.zip'
$checksum       = '7179ad4d6a2f15df3ae565d7dde811c240b3e7e37fea1b5b56c59fef6ff9f444'
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
