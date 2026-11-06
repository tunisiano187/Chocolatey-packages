$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.54.2/Nuclear_1.54.2_x64-setup.exe'
  checksum64     = 'E57E2D186DF43CE1F45FEC843EDF86135177B1877788452B3684F4DFE692D209'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
