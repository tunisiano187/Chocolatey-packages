$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = '' # download url, HTTPS preferred
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'kasperskyfree*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/s'           # InstallShield

  validExitCodes= @(0,3010)
}

Install-ChocolateyPackage @packageArgs
