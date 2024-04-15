$ErrorActionPreference = 'Stop';
$url            = 'https://dl.makeblock.com/mblock5/win32/V5.4.0.exe'
$checksum       = 'c583bd8db64287fdebdad9a9a6d71e41938dfb0e1155d0f87675b809430aa6aa'
$checksumType   = 'sha256'
$referer        = 'https://www.mblock.cc/en/download/'


# Add referer
$options =
@{
  Headers = @{
    Cookie = 'requiredinfo=info';
    Referer = 'https://somelocation.com/';
  }
}

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'mblock*'

  checksum      = $checksum
  checksumType  = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs    = '/S'
  Options       = $options
}

Install-ChocolateyPackage @packageArgs
