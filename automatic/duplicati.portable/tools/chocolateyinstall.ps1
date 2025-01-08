$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.105_canary_2025-01-07/duplicati-2.1.0.105_canary_2025-01-07-win-x64-gui.zip'
$checksum       = 'bacb05d538bb0704c9bf978b0f1afc1708b84e56030c880de9a919fb495ca92d'
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
