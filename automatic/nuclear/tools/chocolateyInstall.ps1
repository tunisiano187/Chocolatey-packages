$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.53.1/Nuclear_1.53.1_x64-setup.exe'
  checksum64     = '2B882431672BD2B6FEB0D03BB2BED33AD29E812CDB28C775F45FD06C5DC16312'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
