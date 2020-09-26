$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.5.111-2.0.5.111_canary_2020-09-26/duplicati-2.0.5.111_canary_2020-09-26.zip'
$checksum       = '242ec9be83b65bcccb59c9c3dd9bb8dd5bfb5fa85a34478c7f2740a07d57550c'
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
