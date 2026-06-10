$ErrorActionPreference = 'Stop'
$packageName    = 'futuremark-systeminfo'
$url            = 'https://d1ejs5fxm96rib.cloudfront.net/Futuremark_SystemInfo_5_92_1497.msi'
$checksum       = '4be6356ce14ada5ec61d0bb7ad556ed17ff2fa99ea42a24d2700f951a1ea5ee6'
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
