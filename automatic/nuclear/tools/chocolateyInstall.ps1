$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.56.0/Nuclear_1.56.0_x64-setup.exe'
  checksum64     = '3D11B034D0E27C86CB2D93A5C67CAA8310E7245063FC1F5072E36BD34659768D'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
