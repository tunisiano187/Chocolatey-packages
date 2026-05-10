$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.1/ultracopier-windows-x86-3.0.2.1-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.1/ultracopier-windows-x86_64-3.0.2.1-setup.exe'
$checksum32='9891fb369b554fbe38236d1161c3f483613445308c756021143c12cef1e7ff64'
$checksum64='7ca665f231dd2b468b4377e7970a043b7a612206e5ec29c7186aac8f5d1dfcea'
$checksumType='sha256'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = $checksum32
  checksumType  = $checksumType
  checksum64      = $checksum64
  checksumType64  = $checksumType


  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

