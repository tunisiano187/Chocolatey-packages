$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.48.5/Nuclear_1.48.5_x64-setup.exe'
  checksum64     = '1854E6AFDEC95A6E34074EB83846D9DD6B61763A8D724BF2D4E0879D8E308F62'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
