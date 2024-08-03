$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.9.102_canary_2024-08-02/duplicati-2.0.9.102_canary_2024-08-02-win-x64-gui.zip'
$checksum       = 'f82321375000ddce8dcea291fc76f218e9d813c477623f6ccfbc2b0dfb1bc2f5'
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
