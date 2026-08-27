$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.58.2/WinMerge-2.16.58.2-Setup.exe'
$checksum32     = '6bb69e48757307c7b258e381c3578dc0523fe71f677b536cb7eb6be726bbf2b2'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.58.2/WinMerge-2.16.58.2-x64-Setup.exe'
$checksum64     = '26f794838bc4e545d7b9f36dc8beeb5a65a12bd4627fa3b4fe87068abef925b0'
$checksumType64 = 'sha256'

if ($PackageParameters.shellextension) {
  $pp = '/TASKS="-ShellExtension"'
} else {
  $pp = ''
}

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url32
  checksum               = $checksum32
  checksumType           = $checksumType32
  url64bit               = $url64
  checksum64             = $checksum64
  checksumType64         = $checksumType64
  silentArgs             = "/VERYSILENT /SP- /NORESTART $pp"
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}

Install-ChocolateyPackage @packageArgs
