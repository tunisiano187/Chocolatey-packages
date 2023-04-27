$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.30/WinMerge-2.16.30-Setup.exe'
$checksum32     = '6fc6c6179fa1e6b2629ee40633193035d6e0f433c91891787368e6f92872f5c2'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.30/WinMerge-2.16.30-x64-Setup.exe'
$checksum64     = 'abb01254f569f6723656aa6c7c9eba0b4214357049c1934acc67fd04f9836111'
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
