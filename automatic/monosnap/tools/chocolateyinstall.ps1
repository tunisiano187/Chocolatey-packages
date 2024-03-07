$ErrorActionPreference = 'Stop';

$url          = ''
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName    = 'monosnap'
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  softwareName   = 'monosnap*'
  checksum       = $checksum
  checksumType   = $checksumType
  toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
}
Install-ChocolateyPackage @packageArgs
