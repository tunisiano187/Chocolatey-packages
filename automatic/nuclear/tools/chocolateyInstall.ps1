$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.54.0/Nuclear_1.54.0_x64-setup.exe'
  checksum64     = '830A01EDD11F39CAEAF0154CBB53EC8EEDC9F3536BDA822B672B0E6A9EDA94D2'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
