$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.52.0/Nuclear_1.52.0_x64-setup.exe'
  checksum64     = 'E9566D863FD767E3B2125195FA98E2C7596A705F8CD9B8C32C70305C4208D107'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
