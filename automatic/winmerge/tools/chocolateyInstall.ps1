$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.34/WinMerge-2.16.34-Setup.exe'
$checksum32     = '687f15c55bbc431185dc024f13cded77c821ba431efd3148bb2bbf692580433b'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.34/WinMerge-2.16.34-x64-Setup.exe'
$checksum64     = '8873b7e9f26ee52a8babccd5a79b941226c182c027f91e44d18744f53595b6b7'
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
