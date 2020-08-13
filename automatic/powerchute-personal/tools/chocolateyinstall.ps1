$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$url              = 'https://cdist2.perforce.com/perforce/r20.1/bin.ntx86/p4vinst.exe'
$checksum         = '5b7ce5100cbdd7cfb5732d28d39beec9ca9f9e4a72fa52b3c5f26cc683cfac4e'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  fileType        = 'EXE'
  url             = $url

  softwareName    = '$packageName*'

  checksum        = $checksum
  checksumType    = $checksumType

  validExitCodes  = @(0, 3010, 1641)
  silentArgs      = '/S'
}

Install-ChocolateyPackage @packageArgs