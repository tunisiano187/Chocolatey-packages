$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/yang991178/fluent-reader/releases/download/v1.2.2/Fluent.Reader.Setup.1.2.2.x86.exe' # download url, HTTPS preferred
$checksum     = 'd3ac8178eea9d533174cda6a6f9da23c21cb203da8a4f6cbb02824ebdec6c049'
$url64        = 'https://github.com/yang991178/fluent-reader/releases/download/v1.2.2/Fluent.Reader.Setup.1.2.2.x64.exe' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64   = '8b62c3804bc9664676add4f06b2b92b4d36f38c39caa6af89788f34f30030cae'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'fluent-reader*'

  checksum      = $checksum
  checksumType  = $checksumType
  checksum64    = $checksum64
  checksumType64= $checksumType

  validExitCodes= @(0, 3010, 1641)

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
