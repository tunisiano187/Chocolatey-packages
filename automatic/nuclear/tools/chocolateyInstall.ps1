$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.40.0/Nuclear_1.40.0_x64-setup.exe'
  checksum64     = '1175EA4BD15D0F1FECE0AC90E155EFF9396C5CA886257F2F192729C67C765BAD'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
