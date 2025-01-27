$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_5_79_1331.msi'
$checksum       = '53c048fa84c9c09209e9ef5fbaa9377ad0c2fb81412318f76f56fbf4635a7bdc'
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
