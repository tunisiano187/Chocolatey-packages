$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file             = Join-Path $toolsDir '/p4vinst64.exe'
$checksum         = '26174EFAB2F3C4C50BD53243894D2C5C1B940D84D9A07A9BC787599620C8B846'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  file            = $file

  softwareName    = 'Helix Core*'

  checksum        = $checksum
  checksumType    = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/s REMOVEAPPS=P4V,P4ADMIN,P4'
}

Install-ChocolateyPackage @packageArgs
