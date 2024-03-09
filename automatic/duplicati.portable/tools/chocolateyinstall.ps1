$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.7.101-2.0.7.101_canary_2024-03-08/duplicati-2.0.7.101_canary_2024-03-08.zip'
$checksum       = '870504f05fdda8c17abf89af4d81ef0ce84365e2cc179c34d4a64427910fa6b3'
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
