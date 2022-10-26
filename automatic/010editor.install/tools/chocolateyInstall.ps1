$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Installer.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Installer.exe'
$checksum32  = '832f548a0a8850d353e3fc67d7c65301883f07f035131aa77d3144653a4c40e5'
$checksum64  = '4c55d604397db9789b0eb39042707cbcf0bd36d5b43910f47462955b2b53332f'

$packageArgs = @{
  packageName   = '010editor.install'
  fileType      = 'EXE'
  softwareName  = '010 Editor*'

  checksum      = $checksum32
  checksumType  = 'sha256'
  url           = $url32

  checksum64    = $checksum64
  checksumType64= 'sha256'
  url64bit      = $url64

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
