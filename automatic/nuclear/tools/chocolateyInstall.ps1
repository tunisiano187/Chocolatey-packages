$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.47.0/Nuclear_1.47.0_x64-setup.exe'
  checksum64     = '50BE38A242EEE5EAD308EBA4925D5B6FEEDCBDEA3BA581A663F37CF9D920F8E5'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
