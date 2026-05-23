$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.37.4/Nuclear_1.37.4_x64-setup.exe'
  checksum64     = 'BC9302C8C424C9B2F4EF15B71520F92B334FCCBD73D0E7113BA3DAA1CF5D4A49'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
