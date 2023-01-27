$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.26/WinMerge-2.16.26-Setup.exe'
$checksum32     = '7a9b355d8f14203fb144661da3cce2ae2cca7cb3fc3032263646bf1c0001ca53'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.26/WinMerge-2.16.26-x64-Setup.exe'
$checksum64     = 'e956e7c2dac35f397e788632594a465ea055140bade1b7fc80e0d205962f4e21'
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
