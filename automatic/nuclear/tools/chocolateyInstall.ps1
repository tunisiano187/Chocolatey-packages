$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.40.1/Nuclear_1.40.1_x64-setup.exe'
  checksum64     = 'AD3D86B2634638B05CFEBABF5F1476B42C03A4C2FF97F3C30E8E08D924A50C43'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
