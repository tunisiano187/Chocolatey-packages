$ErrorActionPreference = 'Stop'

$packageName = 'tsedat'
$url = 'https://www.sequencepublishing.com/_files/TheSage_Setup_7-74-2826.exe'
$checksum = '525bf3ca49f5f85e812c8cfb9fb71c24ffa31261a09286dde2b23718359f7b3c'
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
