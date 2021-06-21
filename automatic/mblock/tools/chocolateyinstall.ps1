$ErrorActionPreference = 'Stop';
$url            = 'https://dl.makeblock.com/mblock5/win32/V5.3.5.exe'
$checksum       = '1fdb4587fa3a6040a5e69287de1d8f10cc4042a0ea291b229d63e186144533a2'
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
