$ErrorActionPreference = 'Stop'
$url			= 'https://static.idriveonlinebackup.com/downloads/012821/IDriveWinSetup.exe'
$checksum		= '77de8f9deb14cc8f708f5c9737b599a6b07264432f7b38c759f29fde8168fbc4'
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
