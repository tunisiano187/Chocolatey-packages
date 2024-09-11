$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = ''
$checksum     = ''
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'cuetools*'
  fileType      = 'zip'
  silentArgs    = "/S"
  validExitCodes= @(0) #please insert other valid exit codes here
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  destination   = $toolsDir
}

Install-ChocolateyZipPackage @packageArgs

## See https://docs.chocolatey.org/en-us/create/functions/