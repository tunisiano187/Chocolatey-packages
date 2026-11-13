$ErrorActionPreference = 'Stop'
$packageName = 'nuclear'
$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url64bit       = 'https://github.com/nukeop/nuclear/releases/download/player%401.55.0/Nuclear_1.55.0_x64-setup.exe'
  checksum64     = 'C357FE5EFD40BDAAB872F38DF9EBB14E4B2BD828B8D0C7EA5C8001272F0E94A8'
  checksumType64 = 'sha256'
  silentArgs     = '/S'
  validExitCodes = @(0)
}
Install-ChocolateyPackage @packageArgs
