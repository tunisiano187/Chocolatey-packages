$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.52.2/WinMerge-2.16.52.2-Setup.exe'
$checksum32     = '074d9f175a8cf13d8117b3c75180ce978a47f10efc8c34888ee5380b6dbfd334'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.52.2/WinMerge-2.16.52.2-x64-Setup.exe'
$checksum64     = 'f0b8094da0df8f3b6ed02ddda01b8c6264a48d7db0d1ccafb09a16e9090cbe8a'
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
