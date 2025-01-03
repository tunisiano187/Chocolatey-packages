
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://nightly.kvirc.net/win-x86_64/KVIrc-5.2.6-qt5-dev-2025-01-03-git-ca7cb5a.exe'
$checksum       = '6c1af6bf872e842b357d5670db4b7f5d163a7096e7d69c98506fbeaeb48c731d'
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
