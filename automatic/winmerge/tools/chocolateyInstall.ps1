$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.54.2/WinMerge-2.16.54.2-Setup.exe'
$checksum32     = '77647e20eba4d511f2adde621bffc6588d0e991c41d2b138161a8557b9883f58'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.54.2/WinMerge-2.16.54.2-x64-Setup.exe'
$checksum64     = 'a205c9d6fa8426030b746dec34b5da0892e47c276bb4515a130c204c50036b2c'
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
