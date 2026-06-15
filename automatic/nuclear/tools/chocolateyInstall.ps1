$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.40.2/Nuclear_1.40.2_x64-setup.exe'
  checksum64     = 'E70F0674D71E7902DE94C0A94F022B331FF5E31EE0321C9BF39A881304F38D35'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
