$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.16/WinMerge-2.16.16-Setup.exe'
$checksum32     = '3f82f186538c36329bce21da502b12e11749666c0dafc03019d4c69a0ce61e74'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.16/WinMerge-2.16.16-x64-Setup.exe'
$checksum64     = 'cc9ebbc111833a4c5d73b03443533f833e8967f0774d33a093f0da5409799106'
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
