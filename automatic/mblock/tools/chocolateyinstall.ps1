$ErrorActionPreference = 'Stop';
$url            = 'https://dl.makeblock.com/mblock5/win32/V5.3.0.exe'
$checksum       = 'ecb8a53af718a76dbc0c05515c241705bf3c148623fa0a62e7f6cb9088d8a561'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'mblock*'

  checksum      = $checksum
  checksumType  = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-ChocolateyPackage @packageArgs
