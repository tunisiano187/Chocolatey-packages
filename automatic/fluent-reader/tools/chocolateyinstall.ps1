$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url64        = 'https://github.com/yang991178/fluent-reader/releases/download/v1.2.2/Fluent.Reader.Setup.1.2.2.x64.exe' # 64bit URL here (HTTPS preferred)
$checksum64   = '8b62c3804bc9664676add4f06b2b92b4d36f38c39caa6af89788f34f30030cae'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = 'fluent-reader*'

  checksum64    = $checksum64
  checksumType64= $checksumType

  validExitCodes= @(0, 3010, 1641)

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
