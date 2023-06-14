$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.6.7/ultracopier-windows-x86-2.2.6.7-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.6.7/ultracopier-windows-x86_64-2.2.6.7-setup.exe'
$checksum32='20d63ef74f93b01ecfafff73753f3f3ce14918f5b54e4cc8ce856590ac978fb8'
$checksum64='cae96dba1e1e56b71ab750caa507894b629973aad669a6268c61de8345dc4854'

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

