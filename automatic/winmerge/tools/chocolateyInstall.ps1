$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.28/WinMerge-2.16.28-Setup.exe'
$checksum32     = '0ffe0bd5892c59a17c77e560621d9f71c17082b0cf200cde232e63c934747560'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.28/WinMerge-2.16.28-x64-Setup.exe'
$checksum64     = '4cf53b1f713eb858a25201fd15cdf6ec6a8425e27fe0a8cd10856125ccea6d68'
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
