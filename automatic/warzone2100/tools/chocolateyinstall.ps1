$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$url          = 'https://github.com/Warzone2100/warzone2100/releases/download/4.6.3/warzone2100_win_installer.exe'
$checksum     = '9d64331fceac1d64ca480aaf51c703955b71d2d55f577157625353a56a20d261'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = $url
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /ALLUSERS=1'
  softwareName   = 'Warzone 2100*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
