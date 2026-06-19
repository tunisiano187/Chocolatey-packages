$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.40.4/Nuclear_1.40.4_x64-setup.exe'
  checksum64     = 'FE20365EB6118C4CC7F20106F05C0B1CD900499FB1330E2B0CCB9592F64DEBA1'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
