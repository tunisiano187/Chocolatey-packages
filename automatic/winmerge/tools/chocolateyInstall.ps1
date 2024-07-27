$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.42/WinMerge-2.16.42-Setup.exe'
$checksum32     = 'd923e9c0cff3877a724c01d16d32909ba4fb9c5e05811c8371062b8872ed0f33'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.42/WinMerge-2.16.42-x64-Setup.exe'
$checksum64     = '102ff8805c3c31881a7eae1677acdce5c94d3d637aa44d100dd7cdd33e54e2ed'
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
