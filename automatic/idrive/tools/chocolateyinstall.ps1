$ErrorActionPreference = 'Stop'
$url			= 'https://static.idriveonlinebackup.com/downloads/030824/IDriveWinSetup.exe'
$checksum		= 'bba38626f94136703bc603976bf6e2ac67979a6974e6727bf66a9442664d5bc8'
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
