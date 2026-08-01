$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.44.0/Nuclear_1.44.0_x64-setup.exe'
  checksum64     = '50C32841BEFB813F65CCE9CA291F09174265EFBE054EA6EEFC0736B933BC5845'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
