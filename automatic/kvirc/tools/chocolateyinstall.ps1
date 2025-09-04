$ErrorActionPreference = 'Stop'
$ErrorView             = 'NormalView'

$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64           = 'https://github.com/kvirc/KVIrc/releases/download/5.2.8/KVIrc-5.2.8-Quasar-x86_64.exe'
$checksum64      = '7c4c944c8a37a2051556414f8c1833cdebb3c4312afb489da39ea8d96c2c7f32ded704a4ae970c715f8b3094aff89e99f6ae344125497b9e574e633c999ad7a4'
$checksumType    = 'sha512'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url64
  softwareName   = 'KVIrc*'
  checksum       = $checksum64
  checksumType   = $checksumType
  validExitCodes = @(0, 1641, 3010)
  silentArgs     = '/S'
}

Install-ChocolateyPackage @packageArgs
