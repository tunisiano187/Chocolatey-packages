$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.46.3/Nuclear_1.46.3_x64-setup.exe'
  checksum64     = '70A8230FA51B8A3811EB54F69C1409D3F30328B9D3324EC668BAE22760762527'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
