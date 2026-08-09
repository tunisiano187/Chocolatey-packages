$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.46.1/Nuclear_1.46.1_x64-setup.exe'
  checksum64     = '53F73CA5AF2BD9AF6C9664A66D9EFF89335B6BCF7004EEF9D2178EF838FA3F02'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
