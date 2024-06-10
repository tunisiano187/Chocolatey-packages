$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://s3.amazonaws.com/download-aws.futuremark.com/Futuremark_SystemInfo_5_14_693.msi'
$checksum       = 'D79D47D7C5DCD82D5A43546022E79DD3A893CD01D3181CDB210C8567D17C732D'
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
