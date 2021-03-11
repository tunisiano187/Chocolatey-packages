$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.114-2.0.5.114_canary_2021-03-10/duplicati-2.0.5.114_canary_2021-03-10.zip'
$checksum       = '02e046acae6c13a4ffa9d9e0fa8283dd85c90172fd45e4244fb156c57fe205ed'
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
