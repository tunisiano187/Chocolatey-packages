$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r21.1/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r21.1/bin.ntx64/p4vinst64.exe'
$checksum         = 'a5b91b8430406ccca6c15d360c650fc84f95d599da9fed9179dc05a33abd463f'
$checksumType     = 'sha256'
$checksum64       = 'a0bcc21e1f8baee909e80e3d11da1aad6b861966268386ba8b3dfeea033ed853'
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
