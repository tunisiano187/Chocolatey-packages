$packageName    = 'winflector-client'
$softwareName   = 'Windows Driver Package - Era software*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winflector.com/store/free-version/index/id/593'
$checksum       = '7B1BB2A1FCCBFF263AF0432C9976B0FF7417BA174CD6C41BFEE3DBC6FD6ADEC1'
$checksumType   = 'sha256'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0, 3010, 1641)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyPackage @packageArgs
