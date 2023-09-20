$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.6.8/ultracopier-windows-x86-2.2.6.8-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.6.8/ultracopier-windows-x86_64-2.2.6.8-setup.exe'
$checksum32='0dd39be53e02f8683ca7fed37edf24417353888535b1ac3f705e7fcc7a88cd2e'
$checksum64='fa77b194b1c88a84263d30d280da221c38d3f9126e77c49eb6c3ca1f81065d42'

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

