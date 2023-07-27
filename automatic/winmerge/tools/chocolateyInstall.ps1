$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.32/WinMerge-2.16.32-Setup.exe'
$checksum32     = 'b84008733e24bc0816f8ad4bce41e4dee330c5647861820959cb09861acc10fe'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.32/WinMerge-2.16.32-x64-Setup.exe'
$checksum64     = '8d6a6c7c4b6c6c844d993697fa8f0818a8b6213c0e2d64fd97d74478138d53fd'
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
