$ErrorActionPreference = 'Stop';

$packageName = 'ultracopier'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.1/ultracopier-windows-x86-2.2.4.1-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.1/ultracopier-windows-x86_64-2.2.4.1-setup.exe'
$checksum32=''
$checksum64=''

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64      = $checksum64
  checksumType64  = 'sha256'

  
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

