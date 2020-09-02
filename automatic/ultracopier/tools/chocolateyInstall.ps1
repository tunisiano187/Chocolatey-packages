$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.6/ultracopier-windows-x86-2.2.4.6-setup.exe'
$url64='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.6/ultracopier-windows-x86_64-2.2.4.6-setup.exe'
$checksum32='2338cb720598e2874270816ab37b0a8a03b0a90dea895848e0bfa7429ddfdc8f'
$checksum64='acda271b62510b5c7241add63178321bbeb91541824ba0725ed002a392dfcdde'

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

