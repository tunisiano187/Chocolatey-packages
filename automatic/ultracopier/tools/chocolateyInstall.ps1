$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.1/ultracopier-windows-x86-3.0.1.1-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.1/ultracopier-windows-x86_64-3.0.1.1-setup.exe'
$checksum32='bdaaa5b7907cc8a56f3bc48ecce557ac31eaadd98a11de556ff556f0eda4558d'
$checksum64='0a640036e30fea23db03a7ec7a5cbd69c6b34e5e12e124f4fc0244bf686e401b'
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

