$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.9/ultracopier-windows-x86-3.0.0.9-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/3.0.0.9/ultracopier-windows-x86_64-3.0.0.9-setup.exe'
$checksum32='ec0e34dd94c866f536f7761b41aaecef1cb4329d5f6f8933c47874df6ad31735'
$checksum64='82a6c1845763e8573b5e42b9212b8283cdf739fc13598bc7b18b0d83037285ec'
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

