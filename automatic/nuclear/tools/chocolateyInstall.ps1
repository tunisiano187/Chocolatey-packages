$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.48.4/Nuclear_1.48.4_x64-setup.exe'
  checksum64     = '8B99FDA91FD5B0594EA26C206ADE16470D292DAD269431CA3F17C29FB2992A1D'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
