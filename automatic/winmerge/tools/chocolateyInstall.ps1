$ErrorActionPreference = 'Stop'

$packageName    = 'WinMerge'
$url32          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.56.2/WinMerge-2.16.56.2-Setup.exe'
$checksum32     = '43ff623a626e4386552efcd8c2eefdb9c051165e0b1b3e416e0df4123a836ede'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/WinMerge/winmerge/releases/download/v2.16.56.2/WinMerge-2.16.56.2-x64-Setup.exe'
$checksum64     = 'f9887f536e62f0385a384678da5bb427b2ed69b51cbc53827995e0abc6b2f812'
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
