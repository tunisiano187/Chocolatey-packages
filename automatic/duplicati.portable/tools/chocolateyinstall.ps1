$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.0.6.105-2.0.6.105_canary_2023-04-09/duplicati-2.0.6.105_canary_2023-04-09.zip'
$checksum       = '5a86abd4b73fcf181b874ea60bd4b5e9ae8c16e7410da79d267ad0ccba3f4cea'
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
