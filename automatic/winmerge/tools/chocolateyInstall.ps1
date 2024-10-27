$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.44/WinMerge-2.16.44-Setup.exe'
$checksum32     = '66fa368cd3dfeace9e3eaca26c5c94147269adeb7f3e5be03490d3cb155a1580'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.44/WinMerge-2.16.44-x64-Setup.exe'
$checksum64     = '055e960261fc31723856082d2bf1aec2bcc2c71f1ae2d759efec3d766affeaec'
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
