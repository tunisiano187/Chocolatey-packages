$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.50.0/Nuclear_1.50.0_x64-setup.exe'
  checksum64     = '0013145FD3E9A4F9197C4860CE18C9B7764070F56BADA796EE0E1CFB26F9784F'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
