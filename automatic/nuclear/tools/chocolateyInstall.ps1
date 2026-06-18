$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.40.3/Nuclear_1.40.3_x64-setup.exe'
  checksum64     = '3E30A394FBE5B9388E319EAF1C98518E7A8561573D09E0830F9B03536DFDD257'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
