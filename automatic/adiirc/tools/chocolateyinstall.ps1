$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.adiirc.com/AdiIRC.3.3.exe'
$url64      = 'https://www.adiirc.com/AdiIRC64.3.3.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64
  softwareName  = 'AdiIRC*'
  checksum      = 'C486E52BF1EC1EF9BC668675A6EFCD39143C9235B2890A5DDF782B4F0E7C3189'
  checksumType  = 'sha256'
  checksum64    = 'D974BD427BE660D3C54E88BAA898B7B64C58D0EF7A6C8043C32985BEC0026AB2'
  checksumType64= 'sha256'

  validExitCodes= @(1223, 0, 3010, 1641)
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
