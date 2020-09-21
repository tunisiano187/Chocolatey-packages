$ErrorActionPreference = 'Stop';

$packageName = $env:ChocolateyPackageName
$url32='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.7/ultracopier-windows-x86-2.2.4.7-setup.exe'
$url64='https://cdn.confiared.com/files.first-world.info/ultracopier/2.2.4.7/ultracopier-windows-x86_64-2.2.4.7-setup.exe'
$checksum32='509bfb9ebfe1a73ff08c07395f41dc331548037a436b59d5aed782b126ca7cb2'
$checksum64='30b7b9dc158383298bcdcfb38d44764e813cfb226ed35ad40d5b8e40ee8d1c26'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url32
  url64			= $url64

  softwareName  = 'ultracopier*'

  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64      = $checksum64
  checksumType64  = 'sha256'


  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

