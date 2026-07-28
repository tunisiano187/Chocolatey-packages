$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.1.0_beta_2026-07-28/duplicati-2.3.1.0_beta_2026-07-28-win-x64-gui.zip'
$checksum       = '5c6afeebeef516e542b4521e4d6c761b1f368429bc0e1b3ee53963c843124b1d'
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
