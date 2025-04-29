$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.48.2/WinMerge-2.16.48.2-Setup.exe'
$checksum32     = '887038b3bee2a0aa1f0e93b4d0b4b8f065fb07d7ba06ff0dcb837d13c1a3a1e0'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.48.2/WinMerge-2.16.48.2-x64-Setup.exe'
$checksum64     = 'f8adc543b2dc722252b87b92bae982cce9083a642df30329419457a90484dfa3'
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
