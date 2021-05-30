$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.2-2.0.6.2_experimental_2021-05-29/duplicati-2.0.6.2_experimental_2021-05-29.zip'
$checksum       = '3762edf2aa75e75fef1dd3bc49a40bd8fab00c12742c5ca93cd903cd4bb5d6ab'
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
