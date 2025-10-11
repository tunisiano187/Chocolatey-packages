$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.2.3_beta_2025-10-11/duplicati-2.1.2.3_beta_2025-10-11-win-x64-gui.zip'
$checksum       = 'a78c90a9b7521710e8c0ed0a0b356df8e787b5eb856b71a6cd723a6b1d88db18'
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
