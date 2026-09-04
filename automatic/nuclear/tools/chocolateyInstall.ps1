$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.48.1/Nuclear_1.48.1_x64-setup.exe'
  checksum64     = '50BB5CA81541EA8216458A187060FF81BEE75538E5DA534E9052B28F63D6F0EB'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
