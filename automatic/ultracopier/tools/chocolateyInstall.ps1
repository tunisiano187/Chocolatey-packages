$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.5/ultracopier-windows-x86-2.2.4.5-setup.exe'
$url64='http://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.5/ultracopier-windows-x86_64-2.2.4.5-setup.exe'
$checksum32='ecf64cc78ec8903c38896d1b69b440750635e5546c22851761f452d124f3738e'
$checksum64='5f2e390c4599f93ebc3fd782e70213d23537e4ee15b01ab23e32eb981ba777bf'

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

