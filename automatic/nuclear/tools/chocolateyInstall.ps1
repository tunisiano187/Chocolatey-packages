$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.46.2/Nuclear_1.46.2_x64-setup.exe'
  checksum64     = 'FE4FE9D267E190077D0A6A9494DC65C8F75DC6336647E235DAFC8BE60C2C75C2'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
