$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r21.1/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r21.1/bin.ntx64/p4vinst64.exe'
$checksum         = '40ddec492fc318e178d87c7b2fdf3bef794da551aa41d2a8f2efe276751b9f3f'
$checksumType     = 'sha256'
$checksum64       = 'e8e1563b201ec8ad34bb31612d0a4d4436eb95de700fcf1c14281acab5315cf6'
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
