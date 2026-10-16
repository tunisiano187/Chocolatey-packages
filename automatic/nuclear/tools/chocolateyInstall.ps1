$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.51.2/Nuclear_1.51.2_x64-setup.exe'
  checksum64     = '335CBE6057BC9B8CEE79CC44CDEFF9C28316267C282B8A365834F1A41BA16EF4'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
