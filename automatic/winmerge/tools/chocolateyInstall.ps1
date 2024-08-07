$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.42.1/WinMerge-2.16.42.1-Setup.exe'
$checksum32     = '0df72ad10ca01d21f15a0ee173a69bbd8f410f85a7c9738330b4d69628c1e3c1'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.42.1/WinMerge-2.16.42.1-x64-Setup.exe'
$checksum64     = '5771f2a0553f53684b0e74161ed8749c4dda270f166edac253982366aee39bd3'
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
