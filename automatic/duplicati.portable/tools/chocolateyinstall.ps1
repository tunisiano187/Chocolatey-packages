$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.7.102-2.0.7.102_canary_2024-04-03/duplicati-2.0.7.102_canary_2024-04-03.zip'
$checksum       = '46df0472bce7e63554808dd6924b957eb2cd4d7c08b76129d590c2d3c9aa40c2'
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
