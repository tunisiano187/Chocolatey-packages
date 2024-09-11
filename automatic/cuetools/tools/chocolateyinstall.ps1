$ErrorActionPreference = 'Stop';
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://github.com/gchudov/cuetools.net/releases/download/v2.2.6/CUETools_2.2.6.zip'
$checksum     = '103b209502935c911f2162a5babfb21550476413aee13d88187e39783a2a2e32'
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
