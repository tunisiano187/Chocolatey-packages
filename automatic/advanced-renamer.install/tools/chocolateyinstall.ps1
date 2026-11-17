$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.advancedrenamer.com/down/win/advanced_renamer_setup_4_29.exe'
$checksumType  = 'sha256'
$checksum      = '7FE8A1B728369DB15C43ECA7335DB7480D82B740E2D31B4A21A956DD679AD6EC'


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
