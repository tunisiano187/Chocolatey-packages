$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.41.4/Nuclear_1.41.4_x64-setup.exe'
  checksum64     = '182F0E0AD7F02A24BB718F9A5419165F518B3334D14C90B12B57298A6B2DAF65'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
