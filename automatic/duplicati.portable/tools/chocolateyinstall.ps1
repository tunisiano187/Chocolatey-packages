$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.7.2-2.0.7.2_canary_2023-05-25/duplicati-2.0.7.2_canary_2023-05-25.zip'
$checksum       = '1faaf47b824440484c4ca808bc9a22b9125f27df73d33f20f4d6bcc3d7e3245e'
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
