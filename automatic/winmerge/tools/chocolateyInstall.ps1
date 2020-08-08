$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://downloads.sourceforge.net/winmerge/WinMerge-2.16.0-Setup.exe'
$checksum32     = 'a820e09ef8374295849ec7cb3906fb9db10d1f223cde1579ba166fa3b8851639'
$checksumType32 = ''
$url64          = 'https://downloads.sourceforge.net/winmerge/WinMerge-2.16.0-x64-Setup.exe'
$checksum64     = 'AD55CEC5B0A0E72D4EA066ACCA4AE7A2C083C3E85D8EED1A2D8BFB95307C2BEC'
$checksumType64 = ''

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
