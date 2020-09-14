$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.3.3-2.0.3.3_beta_2018-04-02/duplicati-2.0.3.3_beta_2018-04-02.zip' 
$checksum       = '492635C8669E7C1538A35460F2C1F5E2739244C2E8CEFF22A3E5F72997D66A7E'
$checksumType   = ''


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs