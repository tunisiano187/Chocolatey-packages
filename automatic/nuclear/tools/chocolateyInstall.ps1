$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.42.2/Nuclear_1.42.2_x64-setup.exe'
  checksum64     = '9FE28B2ECF9B11CED7DA98292C6E3CCC01F834D3A8E3747E6ECE9CB6FC4A6716'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
