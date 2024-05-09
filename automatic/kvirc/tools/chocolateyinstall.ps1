
$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/kvirc/KVIrc/releases/download/5.2.2/KVIrc-5.2.2-Quasar-x86_64.exe'
$checksum       = 'ebbf9dc260f080b0c0b664639ac5c3d21077de7b2393ae9437f9964c137c1849'
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
