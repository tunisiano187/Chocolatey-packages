$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file             = Join-Path $toolsDir '/p4vinst64.exe'
$checksum         = '17DDDDA36095A0BE7BBFC0BD8B43438F42DE8A5780DD375105F19D7D6622D3CB'
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

Install-ChocolateyInstallPackage @packageArgs
