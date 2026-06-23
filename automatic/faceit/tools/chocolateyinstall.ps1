$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum       = '607389b7771df571dba80b8d589ed70262275291964ce0cf2bc143d56ab4f3d5'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url

  softwareName  = 'faceit*'
  checksum      = $checksum
  checksumType  = $checksumType

  # MSI
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
