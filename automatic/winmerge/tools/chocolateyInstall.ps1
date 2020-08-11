$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com//WinMerge/winmerge/releases/download/2.16.7/WinMerge-2.16.7-Setup.exe'
$checksum32     = '02e8f8bffdadf14d385f1139dbd171f7370f45d6e1486b878a267956d8514b3f'
$checksumType32 = ''
$url64          = 'https://github.com//WinMerge/winmerge/releases/download/2.16.7/WinMerge-2.16.7-x64-Setup.exe'
$checksum64     = 'cba99e028100dcbd3f55d92ec8b374c79a429c3344bf63a53bef119ecbc545ae'
$checksumType64 = ''

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
