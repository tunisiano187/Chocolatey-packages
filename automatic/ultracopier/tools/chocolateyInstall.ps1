$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.11/ultracopier-windows-x86-2.2.4.11-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.11/ultracopier-windows-x86_64-2.2.4.11-setup.exe'
$checksum32='e9494d3773bf1026c98b5afa67126ffe5eaf22474a7302dc0072db613523d3e5'
$checksum64='f4f73676fef6bb413e650c85e3ca3a9309dd6878b5c933cb73c54603e8e2dc91'

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

