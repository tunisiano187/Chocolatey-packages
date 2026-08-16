$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.47.1/Nuclear_1.47.1_x64-setup.exe'
  checksum64     = '99C8099809150C37F15CA58415A76D5D8A37216462958C6BFC8F0BFF6A29D1E9'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
