$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.13/WinMerge-2.16.13-ARM64-Setup.exe'
$checksum32     = '3339193738d5bec722900d5838caf27909b70390be9d29c98f2ecdc6d66f8cfb'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.13/WinMerge-2.16.13-Setup.exe'
$checksum64     = '81253911d433b5fb85df8ba1e97c7a9b11bc65112b8682b39250d9d3ff2a2763'
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
