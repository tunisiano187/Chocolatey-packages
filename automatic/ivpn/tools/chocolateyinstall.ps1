
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.ivpn.net/releases/win/IVPN-Client-v2.7.7.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'ivpn*'
  checksum      = 'c9bb18015efc770cda4cf3c85f744f353e2c20cc'
  checksumType  = 'sha1'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs