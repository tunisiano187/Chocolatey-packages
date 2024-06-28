$packageName    = 'kcast'
$installerType  = 'exe'
$url            = 'http://www.kitco.com/kcastwindows8/v3200/kcastsetup320.exe'
$checksum       = '71ADF8DDCCC22ADE7A1E2ACF55559F13E2FC71F4E927F143CFA27FCFF4464A7F'
$silentArgs     = '/S /v/qn'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$validExitCodes = @(0,1)
$softwareName   = 'Kcast for Windows'

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = $softwareName
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs

