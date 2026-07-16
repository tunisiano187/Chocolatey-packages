$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.43.0/Nuclear_1.43.0_x64-setup.exe'
  checksum64     = '992D5B394DF1C0293DABA4BCBBCCFB4BA974ECC8102E50D3986B55A1166C9DB5'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
