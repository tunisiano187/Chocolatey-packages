$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.3/ultracopier-windows-x86-3.0.2.3-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.2.3/ultracopier-windows-x86_64-3.0.2.3-setup.exe'
$checksum32='3d7e3056fa5b05e963fa9b1db459dd2483325f35b09cd9a870e1c4c4c4ea3485'
$checksum64='f6cacddd2f3e96f576096c386d80149fd2a50c50b74a18629ae19271b749aa4e'
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

