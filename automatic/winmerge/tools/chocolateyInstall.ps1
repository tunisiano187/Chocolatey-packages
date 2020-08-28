$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com//WinMerge/winmerge/releases/download/2.16.8/WinMerge-2.16.8-Setup.exe'
$checksum32     = '0a2eebcd8a7ca35f7787a376e83b44f3650a07229b7ed96f1e986b9567dca89b'
$checksumType32 = 'sha256'
$url64          = 'https://github.com//WinMerge/winmerge/releases/download/2.16.8/WinMerge-2.16.8-x64-PerUser-Setup.exe'
$checksum64     = '8c08c684e356e57e1b6a8c76ff131b048a9e389f9fc41162be8f93d4f232ba1b'
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
