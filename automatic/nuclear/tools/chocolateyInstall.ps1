$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.43.2/Nuclear_1.43.2_x64-setup.exe'
  checksum64     = 'D16892F96A357A60E9F32AF8A38C018CE5F43F6C1A3656F5B68D4656C7EEC1A5'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
