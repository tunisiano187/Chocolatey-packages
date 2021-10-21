$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.14/ultracopier-windows-x86-2.2.4.14-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.14/ultracopier-windows-x86_64-2.2.4.14-setup.exe'
$checksum32='041ee8c0675c2d6a2ce7db46662eafcac3dd08a48dc7454cb802ddde812f527c'
$checksum64='8ba1fd332f98570738332089348c60854e7f3f0a64ab953373d6eb219efb5516'

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

