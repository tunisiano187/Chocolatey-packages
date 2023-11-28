$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.36/WinMerge-2.16.36-Setup.exe'
$checksum32     = '8aaf2387baac301b92a63f526a87b4029b815bd34d74fb1dcf7d04c91e29aaeb'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.36/WinMerge-2.16.36-x64-Setup.exe'
$checksum64     = 'b0876b4c06b4ec513b189ce8ab2dfed745bc24b6ef948ff73d86c34e877ad095'
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
