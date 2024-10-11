
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://nightly.kvirc.net/win-x86_64/KVIrc-5.2.6-qt5-dev-2024-10-11-git-0e01bc6.exe'
$checksum       = '6f6af58b497544e058735d5c5c9084580b79833520a39f035b1b85fade7eefe0'
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
