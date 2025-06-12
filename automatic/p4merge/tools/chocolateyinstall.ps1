$ErrorActionPreference = 'Stop';

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file             = Join-Path $toolsDir '/p4vinst64.exe'
$checksum         = '2612EEB839B8D464AEB7C0157CE039015AFA250B7C4DEF46655AF6F74E59380E'
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
