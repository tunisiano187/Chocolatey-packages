$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/lbryio/lbry-desktop/releases/download/v0.53.5-t109/LBRY_0.53.5-t109.exe'
$checksum       = 'a1d1117b3101cd531bccfc7d8fbcda46844ffebc2b1a3a9fada26aebc0a941de'
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
