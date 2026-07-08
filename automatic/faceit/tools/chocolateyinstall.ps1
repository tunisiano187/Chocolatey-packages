$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://faceit-client.faceit-cdn.net/release/FACEIT-setup-latest.exe'
$checksum       = '070338d5c00b62d0664aaea3e8f693383916ff7d10677320955eb9cf0a1875ee'
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
