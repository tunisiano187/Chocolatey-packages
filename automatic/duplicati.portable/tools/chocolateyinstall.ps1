$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://github.com/duplicati/duplicati/releases/download/v2.1.1.0_experimental_2025-07-17/duplicati-2.1.1.0_experimental_2025-07-17-win-x64-gui.zip'
$checksum       = 'fac9b4e129c92102bb6abe7055082bb08c2f3f5300a66b453bce99bc0c6f23cd'
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
