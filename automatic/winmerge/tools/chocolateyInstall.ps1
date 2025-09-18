$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.50.2/WinMerge-2.16.50.2-Setup.exe'
$checksum32     = '28feeb222a177386df65053740ab067ab99420df1651a433cd7bcd4eab6f4898'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.50.2/WinMerge-2.16.50.2-x64-Setup.exe'
$checksum64     = '49f7185f6253df66535356baf0e43a15f184efdafe9db7a25f6a579c63e86870'
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
