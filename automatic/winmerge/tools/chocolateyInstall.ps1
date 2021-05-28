$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.12/WinMerge-2.16.12-ARM64-Setup.exe'
$checksum32     = '18a0c849921e62dde02fb2d4e4e37d84b4f6607a342ccbeb89b87d783959533d'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.12/WinMerge-2.16.12-Setup.exe'
$checksum64     = '3a509875927cd7b9e583d4cfbdf868fb733049c0f5c93b1df2ec6df327ec707f'
$checksumType64 = 'sha256'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  checksum               = $checksum32
  checksumType           = $checksumType32
  url64bit               = $url64
  checksum64             = $checksum64
  checksumType64         = $checksumType64
  silentArgs             = '/VERYSILENT /SP- /NORESTART'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}

Install-ChocolateyPackage @packageArgs
