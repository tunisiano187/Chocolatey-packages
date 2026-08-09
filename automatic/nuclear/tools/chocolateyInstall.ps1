$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.46.0/Nuclear_1.46.0_x64-setup.exe'
  checksum64     = '41863AE6941502AADD3C7F0C3BF99C81DDADCEACD6A0BD1DCD01408BBFAF9C0A'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
