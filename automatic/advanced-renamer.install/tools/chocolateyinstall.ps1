$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.advancedrenamer.com/down/win/advanced_renamer_setup_4_21.exe'
$checksumType  = 'sha256'
$checksum      = '036E038DF7987A2C658B672E7E5D001507ACB52B9A1CFF83E338CA0774B9FA89'


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
