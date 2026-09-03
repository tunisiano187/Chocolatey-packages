$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://www.sequencepublishing.com/_files/TheSage_Setup_7-76-2828.exe'
$checksum = '25d97ac7921a5a7e750afda1ff0862896365098e2098cd0dc639447ecd843d69'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'exe'
  url            = $url
  silentArgs     = '/S'
  validExitCodes = @(0)
  checksum       = $checksum
  checksumType   = $checksumType
}

Install-ChocolateyPackage @packageArgs
