$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.18/WinMerge-2.16.18-Setup.exe'
$checksum32     = 'c7d09a3917bc8046e35b4f7ed747fcab83c725c61d700def87eb0d33f1ecd888'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.18/WinMerge-2.16.18-x64-Setup.exe'
$checksum64     = '67bfc32e2d9027f4e42606c790fc134cc20a400c6cb2d98188a508880b14d998'
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
