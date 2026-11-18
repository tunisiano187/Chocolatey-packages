$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.advancedrenamer.com/down/win/advanced_renamer_setup_4_29_1.exe'
$checksumType  = 'sha256'
$checksum      = '7554FD5FF3A0918341600071C1CEB2541BBB1F37E665BF52A9F025977323C06D'


$packageArgs = @{
  packageName       = 'advanced-renamer.install'
  fileType          = 'EXE'
  url               = $url
  checksum          = $checksum
  checksumType      = $checksumType
  softwareName      = 'Advanced Renamer*'
  silentArgs        = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}


Install-ChocolateyPackage @packageArgs
