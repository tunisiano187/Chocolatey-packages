$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = 'https://www.advancedrenamer.com/down/win/advanced_renamer_setup_4_27.exe'
$checksumType  = 'sha256'
$checksum      = 'EFF5CF7E391BC103573A5FB6C9C374E9ED58EC1312FD456A5EE9D18CA4C013BC'


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
