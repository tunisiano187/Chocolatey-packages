$ErrorActionPreference = 'Stop'
$url			= 'https://static.idriveonlinebackup.com/downloads/031424/IDriveWinSetup.exe'
$checksum		= 'c998cf74e36e9a136e7a0e9a0c13a4e42d9f589ddb88ee61e1b376c16150d9c6'
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
