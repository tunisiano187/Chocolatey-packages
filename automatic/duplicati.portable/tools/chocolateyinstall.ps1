$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.119_canary_2025-05-29/duplicati-2.1.0.119_canary_2025-05-29-win-x64-gui.zip'
$checksum       = 'df7a9789fa2418a19ef951c9ab0da942c7e1f8bb73ba2e8fc34217c1dcb1fdef'
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
