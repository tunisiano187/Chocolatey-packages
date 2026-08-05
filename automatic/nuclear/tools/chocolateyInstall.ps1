$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.45.1/Nuclear_1.45.1_x64-setup.exe'
  checksum64     = '58C6B63DC242C61CC0B86DE266B5DF7DD9E30B6F9F1DD92A4DFE9AF877F2150F'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
