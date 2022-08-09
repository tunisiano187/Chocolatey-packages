$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.22/WinMerge-2.16.22-Setup.exe'
$checksum32     = '1bb6341272182a677f0fd614d48ca7915ede926b3f5745d5144377f82a2f8d45'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.22/WinMerge-2.16.22-x64-Setup.exe'
$checksum64     = 'c56739866703c81c5d23715857007fd9a1023c46f30fe124eac83191ae78d93d'
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
