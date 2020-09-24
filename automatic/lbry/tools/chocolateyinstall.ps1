$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/lbryio/lbry-desktop/releases/download/v0.48.0/LBRY_0.48.0.exe'
$checksum       = 'b6be9c1b3fcf7d6d5186407a9c5657f188c254d18d1b814e24068f3d639e2bcf'
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
