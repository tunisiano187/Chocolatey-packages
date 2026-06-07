$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.39.1/Nuclear_1.39.1_x64-setup.exe'
  checksum64     = '2351234EEBA2DD1896EB9DD1E2DE85E2356D888F44FDB69211EC08770D6CFF65'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
