$ErrorActionPreference = 'Stop';
$url            = 'https://dl.makeblock.com/mblock5/win32/V5.3.0.exe'
$checksum       = '3ba017427350a75f8a03a4078900a20cc75a3614ba530af5cf42b9cb8945337e'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'mblock*'

  checksum      = $checksum
  checksumType  = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
