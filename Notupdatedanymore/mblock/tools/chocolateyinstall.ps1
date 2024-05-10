$ErrorActionPreference = 'Stop';
$url            = 'https://dl.makeblock.com/mblock5/win32/V5.4.3.exe'
$checksum       = 'a83bba255d2d6e424f058c38a204f273a4f40bcac38c8283f551a7056b605640'
$checksumType   = 'sha256'
$referer        = ''


# Add referer
$options =
@{
  Headers = @{
    Cookie = 'requiredinfo=info';
    Referer = $referer;
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
