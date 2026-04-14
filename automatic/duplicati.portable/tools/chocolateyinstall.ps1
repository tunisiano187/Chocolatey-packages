$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.3.0.0_stable_2026-04-14/duplicati-2.3.0.0_stable_2026-04-14-win-x64-gui.zip'
$checksum       = '07b16c1c6b6ec583e1bd05f8bc1b634f0d9cbccb39180cbd0b0880f25755b9d9'
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
