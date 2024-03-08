$ErrorActionPreference = 'Stop';

$url32       = 'https://www.sweetscape.com/download/010EditorWin32Installer.exe'
$url64       = 'https://www.sweetscape.com/download/010EditorWin64Installer.exe'
$checksum32  = 'f80b87bd05f67fd6deb1988ab5ff3a259aae393f7a9fb763f6197b9541700d08'
$checksum64  = '4600e9febf04ecfc5334746bbf86a951eadcca48610a26f5de3d737636443899'

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
