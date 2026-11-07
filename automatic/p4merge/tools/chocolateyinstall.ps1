$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$url64            = 'https://cdist2.perforce.com/perforce/r26.3/bin.ntx64/p4vinst64.exe'
$checksum         = '29F413112E41A34DDD375D10576CF177A62380664032250FFB96D2B1FD59281A'
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
