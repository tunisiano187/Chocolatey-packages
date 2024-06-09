
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://nightly.kvirc.net/win-x86_64/KVIrc-5.2.4-dev-2024-06-09-git-cf26a20.exe'
$checksum       = 'e0d1c5589551953545aa40b28ccd5958e7a2228020ef56df8b9f6371d5b2a0c5'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'KVIrc*'
  checksum      = $checksum
  checksumType  = $checksumType
  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
