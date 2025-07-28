$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_5_85_1374.msi'
$checksum       = '6662a329dcac5fd540b9598ac5a0fa8a3a99c7b486e945efa17acdea427839dd'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'MSI'
  url            = $url
  validExitCodes = @(0, 3010, 1641)
  silentArgs     = '/quiet /qn /norestart'
  softwareName   = 'Futuremark SystemInfo*'
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
