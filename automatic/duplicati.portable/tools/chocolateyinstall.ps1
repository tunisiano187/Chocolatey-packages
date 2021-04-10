$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.0-2.0.6.0_experimental_2021-04-09/duplicati-2.0.6.0_experimental_2021-04-09.zip'
$checksum       = '592b3e42082af5c79a4badcfe299fc823e6bd29f7b283e4bba2afa8626c8f912'
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
