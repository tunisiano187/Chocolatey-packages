$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r20.2/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r20.2/bin.ntx64/p4vinst64.exe'
$checksum         = 'c3b91f237140904600f4a67192db13c11f99787b3b97bbefb89bd98f33973b4b'
$checksumType     = 'sha256'
$checksum64       = '496e288c2c6952d80ac937800b559e7ce87d9757c2d044936a6a4e7c6e2184f5'
$checksumType64   = 'sha256'

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
