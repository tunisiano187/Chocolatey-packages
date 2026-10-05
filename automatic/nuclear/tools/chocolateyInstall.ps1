$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.49.2/Nuclear_1.49.2_x64-setup.exe'
  checksum64     = '5158AEAB0D09A2C1A2541A813E36070CD81267DF645E0789FDAD8A7EC95D420E'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
