$ErrorActionPreference = 'Stop';

$packageName = 'shareit'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32='https://cdn.confiared.com/files.first-world.info/shareit/2.2.4.1/shareit-windows-x86-2.2.4.1-setup.exe'
$checksum32=''

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32

  softwareName  = 'shareit*'

  checksum      = $checksum32
  checksumType  = 'sha256'

  
  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

