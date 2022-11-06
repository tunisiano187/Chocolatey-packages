$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.104-2.0.6.104_canary_2022-06-15/duplicati-2.0.6.104_canary_2022-06-15.zip'
$checksum       = '955c6d466a0bb86d9b8f56006ff3b64ed2acae2d5816ebecaa8fe0351145cc3d'
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
