$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.24/WinMerge-2.16.24-Setup.exe'
$checksum32     = 'f34f76da6a8559082b136925d53e4c5c3998dd79851889d1b8df0c6a9c02dc07'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.24/WinMerge-2.16.24-x64-Setup.exe'
$checksum64     = 'dd90278f884c6fd632a704265e049634299da6c34a43bfe14a8be98b24cd308a'
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
