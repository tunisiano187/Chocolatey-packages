$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.7.100-2.0.7.100_canary_2023-12-27/duplicati-2.0.7.100_canary_2023-12-27.zip'
$checksum       = '2cfa87204a489adc6e37afd7c2fb0d67189632c1bc7bf5498812f607d85bafe4'
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
