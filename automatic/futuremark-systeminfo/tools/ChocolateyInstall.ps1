$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_5_78_1322.msi'
$checksum       = '70e33ac39debed00c66b2ffb3b2f54eefa025758a1870c026b8586f832fedaa0'
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
