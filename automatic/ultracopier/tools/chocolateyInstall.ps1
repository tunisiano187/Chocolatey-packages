$ErrorActionPreference = 'Stop';

$packageName = 'ultracopier'
$url32='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.3/ultracopier-windows-x86-2.2.4.3-setup.exe'
$url64='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.3/ultracopier-windows-x86_64-2.2.4.3-setup.exe'
$checksum32='e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
$checksum64='c34f04a8f44be05d39ebb0aad096500f5a8730695add604e6bf9421ae1529319'

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

