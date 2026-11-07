$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$url64            = 'https://cdist2.perforce.com/perforce/r26.2/bin.ntx64/p4vinst64.exe'
$checksum         = '80C592BD948FFE22799D005302ECA50DD5780E80F7C08F3B54436C3867C9B64D'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url64bit        = $url64
  checksum64      = $checksum
  checksumType64  = $checksumType

  softwareName    = 'Helix Core*'

  validExitCodes  = @(0, 3010, 1641)
  silentArgs      = '/s REMOVEAPPS=P4V,P4ADMIN,P4'
}

Install-ChocolateyPackage @packageArgs
