$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.40/WinMerge-2.16.40-Setup.exe'
$checksum32     = 'd90ee78b59f07651372ec976f0a4da2e860129f04440380df7828c19eb5e1030'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.40/WinMerge-2.16.40-x64-Setup.exe'
$checksum64     = 'c76bcfdd5025059f398e94f97d801a4a6cf52bef5b86f88209dcdffb28a141cd'
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
