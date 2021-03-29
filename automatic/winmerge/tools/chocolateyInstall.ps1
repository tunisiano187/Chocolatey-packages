$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.11/WinMerge-2.16.11-Setup.exe'
$checksum32     = 'ee2c5354db46e9190494b76206ec6ddf6807367688de1f262bf8b93c6c5e05bf'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.11/WinMerge-2.16.11-x64-Setup.exe'
$checksum64     = '54ca4e708e8a769a905839bb61bccf869af882e175c7ad8949ddcb37f9855082'
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
