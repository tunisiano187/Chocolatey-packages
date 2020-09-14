$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.110-2.0.5.110_canary_2020-08-10/duplicati-2.0.5.110_canary_2020-08-10.zip'
$checksum       = '69720d935b4d9ca1383d53cfc9308727fac8ac48683d2ac9f7d1487849c4a7c8'
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
