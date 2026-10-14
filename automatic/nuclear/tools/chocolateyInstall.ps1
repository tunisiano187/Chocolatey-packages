$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.51.1/Nuclear_1.51.1_x64-setup.exe'
  checksum64     = '096D87B0EB5549D32854B520A1CE36DEE6FA7883A611E20FDB2F3BA04CEA767C'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
