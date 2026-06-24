$packageName    = 'winflector-client'
$softwareName   = 'Windows Driver Package - Era software*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://www.winflector.com/store/free-version/index/id/567'
$checksum       = 'BFB8F997FF9431B340C64063E347F57A3DB10F9112CC427E6443AE97BCF07126'
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
