$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.50/WinMerge-2.16.50-Setup.exe'
$checksum32     = '73ced7fd301f037f69328d6d490306a1695eabe1a144c62beea0823cf986688a'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.50/WinMerge-2.16.50-x64-Setup.exe'
$checksum64     = '1ed2819a990011a23838809d587891f52674c507e2ff63b8e97b4430e7484177'
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
