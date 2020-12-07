$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx64/p4vinst64.exe'
$checksum         = 'cf8e009c0219745cf8085c6ee479d7bdea36513c4690e50e7770a42e7aeecd6d'
$checksumType     = 'sha256'
$checksum64       = 'b6a8384824f2523ddd691dc47f9870102bcca731734f8559bbdb4e7cc1393e2d'
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
