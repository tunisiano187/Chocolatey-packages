$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/2.16.9/WinMerge-2.16.9-Setup.exe'
$checksum32     = '74ccfcf69d051299eb6764383303e0e2b1ae61e7502471e95a27cc3642425969'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/2.16.9/WinMerge-2.16.9-x64-Setup.exe'
$checksum64     = 'fc3628f4cc5e0f1f4978689bd7d6a081bdcabb1fa1f06981e2f9055c1a208b39'
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
