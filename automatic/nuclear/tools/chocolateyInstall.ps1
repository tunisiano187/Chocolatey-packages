$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.56.4/Nuclear_1.56.4_x64-setup.exe'
  checksum64     = 'AF3492252C05D7CA86CC1B090A5A03D9A5DFA0CD422FED799E63A010AF684A7A'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
