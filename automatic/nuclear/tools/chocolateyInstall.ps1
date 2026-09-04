$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.48.3/Nuclear_1.48.3_x64-setup.exe'
  checksum64     = 'B832EDC98CE1CE11C25E7794F009AAF024CBC0735669D39B5443A37BC9419D31'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
