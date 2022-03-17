$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.101-2.0.6.101_canary_2022-03-13/duplicati-2.0.6.101_canary_2022-03-13.zip'
$checksum       = '98ae11e9374b2fcf7ed4c57eb4b4ea26b4b1f6b1ffb3ad5ec69805c2502a4768'
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
