$ErrorActionPreference = 'Stop' # stop on all errors

$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url          = 'https://github.com/yang991178/fluent-reader/releases/download/v1.2.1/Fluent.Reader.Setup.1.2.1.x86.exe' # download url, HTTPS preferred
$checksum     = '56a0ea30c1f9c70723ea3ef3694636b737c8b4d69c15760e0b622f37ddfb0f8c'
$url64        = 'https://github.com/yang991178/fluent-reader/releases/download/v1.2.1/Fluent.Reader.Setup.1.2.1.x64.exe' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
$checksum64   = '51b63bb629e2a7686245a9671b0377d565d9d077ac202538ccdf79735703e3f9'
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
