$ErrorActionPreference = 'Stop'
$packageName  = 'dell-platform-tags-utility' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'https://downloads.dell.com/FOLDER06126915M/2/PlatTagsSWB40300_ZPE.exe'
$checksum     = '8A0926B89834BAAA1AE9E4A9A985AD2C46975127F8A3BFAB99950C3DABD4C224'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
