$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.4/ultracopier-windows-x86-2.2.4.4-setup.exe'
$url64='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.4/ultracopier-windows-x86_64-2.2.4.4-setup.exe'
$checksum32='8a5064a7fef706a3d7bd13ba52926c50486419763dee0fc1a65e0199ef7db2df'
$checksum64='d15bc427edc892c68e60cde2e7972df4aac0eca55a2a0bce9c425cad5ac3f016'

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

