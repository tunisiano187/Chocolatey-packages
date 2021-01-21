$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.112-2.0.5.112_canary_2021-01-20/duplicati-2.0.5.112_canary_2021-01-20.zip'
$checksum       = '61f84d13ec0f20023922f01a5d61ad77c4a724d88763b8e393fb81ac8ceb6607'
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
