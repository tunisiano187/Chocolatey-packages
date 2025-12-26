$ErrorActionPreference = 'Stop'
$packageName  = 'warzone2100'
$url          = 'https://github.com/Warzone2100/warzone2100/releases/download/4.6.2/warzone2100_win_installer.exe'
$checksum     = '8d09ec0448b642a9e54f2ee912b04a669127f0ee8fcf3d6aab5aea3e3cc20a0a'
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
