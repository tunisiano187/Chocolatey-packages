$ErrorActionPreference = 'Stop'
$packageName    = 'gsuite-migration-exchange'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://dl.google.com/exchangemigration/googleworkspacemigration.msi'
$checksum       = '0ff4c72cca6abfd3a1e3f49ede1bd670243144acacd2d24b4fdaa9d46979f1c2'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'G Suite Migration For Microsoft*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
