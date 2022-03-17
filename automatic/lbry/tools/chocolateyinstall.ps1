$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/lbryio/lbry-desktop/releases/download/v0.52.6-alpha.2/LBRY_0.52.6-alpha.2.exe'
$checksum       = 'cd32e20f00ccb0aeb3f689afda219dadbe7915bf92aa51b58c232330cc0b365c'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'lbry*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
