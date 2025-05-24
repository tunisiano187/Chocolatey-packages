$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.0/ultracopier-windows-x86-3.0.1.0-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.1.0/ultracopier-windows-x86_64-3.0.1.0-setup.exe'
$checksum32='9a35f4b71fc90709478551c17d556d6bfa1398770cca3ed21c94a913046aa3ba'
$checksum64='e4dac636cf90d2741c6f65721018133ac29e3599e1bba3ea8d55418e54917213'
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

