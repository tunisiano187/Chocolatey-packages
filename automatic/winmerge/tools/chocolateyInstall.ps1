$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.48/WinMerge-2.16.48-Setup.exe'
$checksum32     = '26a4d526e8128e0aa8e3ea2bc253cf8e1a452db31bd92206fca60559385e4451'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.48/WinMerge-2.16.48-x64-Setup.exe'
$checksum64     = 'aa69ac7a9caf84505ac672f5351fdd58aaffee8e823f13ef79706ccc5cb01c14'
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
