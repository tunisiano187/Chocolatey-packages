$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum       = 'a360d6e9fce53725b67dbcc75bfbeaa1526d54001611b606a6ad2a07517d2d7e'
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
