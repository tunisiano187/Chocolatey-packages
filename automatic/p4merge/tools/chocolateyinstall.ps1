$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx64/p4vinst64.exe'
$checksum         = 'b6e10012dfe313525a8bad6d042083e9ce2657108e98f725555a67f307ca1788'
$checksumType     = 'sha256'
$checksum64       = 'aaf7a92b09d9c654f716755dc78fb0c0f5c01c65ad073e7cb0f8b40c8743ae7e'
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
  silentArgs   = '/s REMOVEAPPS=P4ADMIN,P4MERGE,P4'
}

$forceX86 = $env:chocolateyForceX86;
if (-not $forceX86) {
  if (Get-OSArchitectureWidth 64) {
    $packageArgs.silentArgs = '/s REMOVEAPPS=P4V,P4ADMIN,P4'
  }
}

Install-ChocolateyPackage @packageArgs
