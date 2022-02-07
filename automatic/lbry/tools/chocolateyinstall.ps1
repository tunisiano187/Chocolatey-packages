$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/lbryio/lbry-desktop/releases/download/v0.52.2-alpha.4/LBRY_0.52.2-alpha.4.exe'
$checksum       = 'c6e9e998144ffe69db8e2829c47a03ba8f9e111aaaf18350f9952e279158a865'
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
