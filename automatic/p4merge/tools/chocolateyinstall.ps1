$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url              = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx86/p4vinst.exe'
$url64            = 'https://cdist2.perforce.com/perforce/r20.3/bin.ntx64/p4vinst64.exe'
$checksum         = '8b78cda0cd78e8fed73652a89df54b4f3f63737f83c038dbe37d7980b0dd216d'
$checksumType     = 'sha256'
$checksum64       = '7912efe05339ac310b997b051be875b898e6419c7e6bb08958a50a570593329d'
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
