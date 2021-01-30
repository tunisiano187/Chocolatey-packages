$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.10/WinMerge-2.16.10-Setup.exe'
$checksum32     = '3536520e823d841ecca04a1f8624b1ded8c865846211546a5b0c8668426ac5a7'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.10/WinMerge-2.16.10-x64-Setup.exe'
$checksum64     = '6e9cd0d92eb721bd40974de4cc1cfb0b69e497dcfffbbc50638cf931603247cb'
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
