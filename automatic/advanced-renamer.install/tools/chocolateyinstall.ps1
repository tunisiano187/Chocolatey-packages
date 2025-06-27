$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.winabilitysoftware.com/files/ActiveExitLite-24.5.0-setup.exe'
$checksumType  = 'sha256'
$checksum      = '4D6FFF49D6FEAA1159A5735337440DF8F2E03A925D9BC38ABC767734018D85D0'


$packageArgs = @{
  packageName       = 'advanced-renamer.install'
  fileType          = 'EXE'
  file64            = $url
  checksum          = $checksum
  checksumType      = $checksumType
  softwareName      = 'Advanced Renamer*'
  silentArgs        = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}


Install-ChocolateyPackage @packageArgs
