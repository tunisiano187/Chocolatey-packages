$ErrorActionPreference = 'Stop'
$url			= 'https://static.idriveonlinebackup.com/downloads/062624/IDriveWinSetup.exe'
$checksum		= '77ef45b19d044cc6bc6d7d0ee0315c25ff059b4610cdebca1c6e4f3ca47b974a'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0,3010)
  softwareName  = 'idrive*'
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyPackage @packageArgs
