$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.0.125_canary_2025-07-15/duplicati-2.1.0.125_canary_2025-07-15-win-x64-gui.zip'
$checksum       = '0bcce1ec63d5b67f75159554dad6781b34708b2037b5d83088bb5b941b3639b1'
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
