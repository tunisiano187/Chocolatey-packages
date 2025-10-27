$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.52/WinMerge-2.16.52-Setup.exe'
$checksum32     = 'd6ff1b9f6046d4fd8d4426fdfd5415d8e7ee60dbbc62c0b3487f69011cb56c12'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.52/WinMerge-2.16.52-x64-Setup.exe'
$checksum64     = '8643aa9937f02def3da161ab11e04d1f45a7961f60a47d1358e36f0dbdb6289e'
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
