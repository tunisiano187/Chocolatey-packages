$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.54/WinMerge-2.16.54-Setup.exe'
$checksum32     = 'a67220e5a8c5eb6da1791792939a5186bb474541ea9d5531abacc0713c4895b2'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.54/WinMerge-2.16.54-x64-Setup.exe'
$checksum64     = 'a63baed8eac4f5670ddd101e590fa9ab8ec53709948cbc470a0d14a156dc5632'
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
