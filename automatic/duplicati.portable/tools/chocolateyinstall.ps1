$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.2.0_beta_2025-08-20/duplicati-2.1.2.0_beta_2025-08-20-win-x64-gui.zip'
$checksum       = '46dd5d9e3f53dbb68f1774ca89c2f96f47ad7daed5b2e8b85af14a89497799b2'
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
