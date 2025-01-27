$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.46/WinMerge-2.16.46-Setup.exe'
$checksum32     = '42035dbe4c8eded3afb6f243eb54b35bed539b88c287a5f9d58fdea150f9f657'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.46/WinMerge-2.16.46-x64-Setup.exe'
$checksum64     = 'fc3d0dcff92afd185cd34e4863badd9284f228810777bf0f46acaf6a6e34a3a9'
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
