$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r20.1/bin.ntx86/p4vinst.exe'
$url64            = 'https://filehost.perforce.com/perforce/r19.2/bin.ntx64/p4vinst64.exe'
$checksum         = '5b7ce5100cbdd7cfb5732d28d39beec9ca9f9e4a72fa52b3c5f26cc683cfac4e'
$checksumType     = 'sha256'
$checksum64       = ''
$checksumType64   = ''

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  url             = $url
  url64bit        = $url64

  softwareName    = 'Helix Core*'

  checksum        = $checksum
  checksum64      = $checksum64
  checksumType    = $checksumType
  checksumType64  = $checksumType64

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/s /V"/qn ADDLOCAL=P4MERGE,QT,QT32"'
}

$forceX86 = $env:chocolateyForceX86;
if (-not $forceX86) {
  if (Get-OSArchitectureWidth 64) {
    $packageArgs.silentArgs = '/s /V"/qn ADDLOCAL=P4MERGE,QT"'
  }
}

Install-ChocolateyPackage @packageArgs
