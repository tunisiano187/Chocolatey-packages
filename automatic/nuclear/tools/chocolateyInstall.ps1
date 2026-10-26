$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.52.2/Nuclear_1.52.2_x64-setup.exe'
  checksum64     = 'FFBAE06605F65B4C3AB0241EF032434CACC5C438A2924347B3B5D252556B167E'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
