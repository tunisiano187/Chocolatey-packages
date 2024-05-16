$ErrorActionPreference = 'Stop';

$packageName= 'Anvide Seal Folder'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://anvidelabs.org/download/AnvideSealFolder.exe'
$url64      = ''

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  url64bit      = $url64

  softwareName  = 'Anvide Seal Folder*'

  checksum      = '91D9231A9C11D63F9F34C98C1833A444930E59765A6F0D21347D018438C03A69'
  checksumType  = 'sha256'
  checksum64    = '91D9231A9C11D63F9F34C98C1833A444930E59765A6F0D21347D018438C03A69'
  checksumType64= 'sha256'

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs
