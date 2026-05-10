$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum       = 'cd5e0af7aaebc0bf666b83db7ddfb91b864750a29a2b17baebe5f7fd3407cdcf'
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
