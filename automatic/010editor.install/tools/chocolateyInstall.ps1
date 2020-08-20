$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Installer.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Installer.exe'
$checksum32  = 'bf4d329fc6e21e755de148a35cf2716a28d0a37dbb5d98612df86bc1dff4fb92'
$checksum64  = '2f151a2bf7e7296e35f1e9636cdf18b8eaa15a1e06b945f8b67487acd683ccd7'

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
