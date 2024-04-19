$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.8.0-2.0.8.0_experimental_2024-04-19/duplicati-2.0.8.0_experimental_2024-04-19.zip'
$checksum       = '2af2b4546167c1809ca36a064d60af9aa6cbb666f77f51a1de94d34c43ad8142'
$checksumType   = 'sha256'


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs
