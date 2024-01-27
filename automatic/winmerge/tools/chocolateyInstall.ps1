$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.38/WinMerge-2.16.38-Setup.exe'
$checksum32     = '84ea3821acee25a4489dd428cfbf1c8a38599f29f36ec1a3356ca219041424da'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.38/WinMerge-2.16.38-x64-Setup.exe'
$checksum64     = 'fab6f8279a400f27788b2c1288f7ae4dd4d3eb7ab2f1fd9d6fe58fc1b0797198'
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
