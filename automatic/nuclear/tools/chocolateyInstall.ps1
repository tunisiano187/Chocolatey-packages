$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.53.0/Nuclear_1.53.0_x64-setup.exe'
  checksum64     = '6A01F5614C3649F912B56B63EE342C916F30D622A70B103E0AF2897574E3A5E5'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
