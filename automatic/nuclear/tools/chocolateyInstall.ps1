$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.37.3/Nuclear_1.37.3_x64-setup.exe'
  checksum64     = '63822DBC0AC1773D56DF94166F3736B266AE1096A588D5B6A498F578B01F74BC'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
