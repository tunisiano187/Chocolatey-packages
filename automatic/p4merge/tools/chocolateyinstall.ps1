$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file             = Join-Path $toolsDir '/p4vinst64.exe'
$checksum         = 'BD6EB8BE048BFFF672A1EAA36E0D2440BE5CE97764F308FEC08F6482A9D7398D'
$checksumType     = 'sha256'

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $toolsDir
  fileType        = 'EXE'
  file            = $file

  softwareName    = 'Helix Core*'

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/s REMOVEAPPS=P4V,P4ADMIN,P4'
}

Install-ChocolateyPackage @packageArgs
