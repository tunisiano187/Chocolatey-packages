$ErrorActionPreference = 'Stop'

$url          = '{{DownloadUrl}}'
$checksum     = ''
$checksumType = '{{ChecksumType}}'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'samsung-dex*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs