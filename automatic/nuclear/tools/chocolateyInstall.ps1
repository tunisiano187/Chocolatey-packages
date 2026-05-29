$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.38.0/Nuclear_1.38.0_x64-setup.exe'
  checksum64     = '7C260843255AAD3B2F8809A8C94F9E1E467B56DE0C7137E62904A851A74BF726'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
