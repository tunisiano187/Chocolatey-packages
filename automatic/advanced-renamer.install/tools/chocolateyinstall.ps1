$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.advancedrenamer.com/down/win/advanced_renamer_setup_4_24.exe'
$checksumType  = 'sha256'
$checksum      = 'DFAC2703115AFC197A64A2F88083D3E5485E9D0D2BE7E4A92FED711564A626D7'


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
