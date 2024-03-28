$ErrorActionPreference = 'Stop'
$url			= 'https://static.idriveonlinebackup.com/downloads/032524/IDriveWinSetup.exe'
$checksum		= 'b942aee940503055323fd31b9e0a3ecb42d0c6ad1c3012ae3f4c633f5304b69f'
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
