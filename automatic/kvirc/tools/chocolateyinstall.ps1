$ErrorActionPreference = 'Stop'
$ErrorView             = 'NormalView'

$toolsDir        = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64           = 'https://nightly.kvirc.net/win-x86_64/KVIrc-5.2.8-dev-2025-12-08-git-b85b55c.exe'
$checksum64      = 'c57d9d7b5fc07c0f0b2a1b4dbb1d969dc8b8f4eb7e1c7d17b944a7db72e4f5ab'
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
