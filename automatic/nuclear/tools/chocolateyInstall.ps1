$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.51.0/Nuclear_1.51.0_x64-setup.exe'
  checksum64     = '8049E117B15EC993488A7814813319EBBE2A3A56CA769C913C7E13F5B477A035'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
