$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$url          = 'https://github.com/Warzone2100/warzone2100/releases/download/4.7.0/warzone2100_win_installer.exe'
$checksum     = '80ee0913413bdf9b6edef8c53a31f89e6613db3b7324cdd98cae8d3cd571b7cf'
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
