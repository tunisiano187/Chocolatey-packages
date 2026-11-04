$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.54.1/Nuclear_1.54.1_x64-setup.exe'
  checksum64     = '7C7BF47445B525F00AB4028FD5D1952E3EC8131A6BBB2FDBC0C40C62C847F7F2'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
