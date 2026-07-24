$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  url            = 'https://sourceforge.net/projects/tigervnc/files/stable/1.16.2/tigervnc-1.16.2.exe/download'
  url64bit       = 'https://sourceforge.net/projects/tigervnc/files/stable/1.16.2/tigervnc64-1.16.2.exe/download'
  checksum       = 'BD1DEF637465DD51A5A51B1C40A37BD9E5E52123BF9CE5AA135B9E35AFB02F10'
  checksumType   = 'sha256'
  checksum64     = '96A0117C8D0D55EA2E2C20E3D9D9A798011DA8C5A813A35CD0B9E006D58BB7F4'
  checksumType64 = 'sha256'
  softwareName   = 'tigervnc*'
  validExitCodes = @(0)
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs
