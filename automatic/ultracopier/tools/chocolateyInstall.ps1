$ErrorActionPreference = 'Stop';

$packageName = 'ultracopier'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32="https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.1/ultracopier-windows-x86-2.2.4.1-setup.exe"
$url64="https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.1/ultracopier-windows-x86_64-2.2.4.1-setup.exe"


$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = '58436D58224F2EC4F6A2DFF12F8771894000F9FAAAEBC6143755F426CB94B55B'
  checksumType  = 'sha256'
  checksum64      = 'D3A50BFD0FF22A3A4A4BA319C44E4958B9C50CA3B49FF2093B58C60A4C4B7E66'
  checksumType64  = 'sha256'

  
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

