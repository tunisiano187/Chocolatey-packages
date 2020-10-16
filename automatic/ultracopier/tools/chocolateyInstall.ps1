$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.8/ultracopier-windows-x86-2.2.4.8-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.8/ultracopier-windows-x86_64-2.2.4.8-setup.exe'
$checksum32='578b7ed7dc353f119c5006b8f6ebe1093926b1806bf954cf64e7e197e50e6153'
$checksum64='18cec14974ae908c5c249ce7fc5880db991a467f6be8fa24995ca665e4dd891d'

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

