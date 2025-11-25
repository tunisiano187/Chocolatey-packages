$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.3/ultracopier-windows-x86-3.0.1.3-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.3/ultracopier-windows-x86_64-3.0.1.3-setup.exe'
$checksum32='c18bfa355129474a9421767331f95f580d15b48339f36d126086727c1baecbe8'
$checksum64='3605d4844e4873bd3b9794173c3845fa6653204563a32b704a2056bc3845679b'
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

