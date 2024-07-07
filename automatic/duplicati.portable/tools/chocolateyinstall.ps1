$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.9.101_canary_2024-06-27/duplicati-2.0.9.101_canary_2024-06-27-win-x64-gui.zip'
$checksum       = '35696c53c14aafc4a2cd6bf64bae85872afe5c4f2dca9d4d0969d5c38b05adf7'
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
