$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_5_81_1354.msi'
$checksum       = 'ebabc44072ef762b178cdc1052d98c05e6f4065e72e158e6adb98940ce1fb626'
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
