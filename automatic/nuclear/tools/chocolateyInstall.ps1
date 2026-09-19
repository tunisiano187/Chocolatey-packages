$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.48.6/Nuclear_1.48.6_x64-setup.exe'
  checksum64     = '0F35326F9F211E0F83DE1B944AE31FCDB1FCE54D199C20D19B1408D122AC7C89'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
