$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.39.0/Nuclear_1.39.0_x64-setup.exe'
  checksum64     = '941ED79AFA079C2893F13D3D8A53CE6312F39674C807B8583B22A460F737F7E0'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
