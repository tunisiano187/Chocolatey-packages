$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.49.1/Nuclear_1.49.1_x64-setup.exe'
  checksum64     = 'B8B7C5B34725DB28E24D85CF5FB303A631A3DA2D634F4AC91F17861F1A5FD440'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
