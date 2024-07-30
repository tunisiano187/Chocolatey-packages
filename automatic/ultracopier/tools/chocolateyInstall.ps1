$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.7.0/ultracopier-windows-x86-2.2.7.0-setup.exe'
$url64='https://cdn.confiared.com/ultracopier.herman-brule.com/files/2.2.7.0/ultracopier-windows-x86_64-2.2.7.0-setup.exe'
$checksum32='40ea3b59df7abd74adfde9b637dffe5be541836cf69ac3a56ca561ea2e755e08'
$checksum64='b0df258303281f4ea46679327511753e258711219696d7d1ef59e8ed4a9189c8'

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

