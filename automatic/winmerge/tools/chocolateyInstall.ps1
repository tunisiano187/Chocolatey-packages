$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.14/WinMerge-2.16.14-Setup.exe'
$checksum32     = 'b41a57df994e27c30ceccfb1565cbbb0a165e1f2620246a913100452e4060258'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.14/WinMerge-2.16.14-x64-Setup.exe'
$checksum64     = 'd7178d74b363357c37731926d64afc41941aba01b8b687ff4ee7b85a5f6089dc'
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
