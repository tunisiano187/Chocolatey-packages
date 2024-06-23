$packageName    = 'winflector-client'
$global:packageMaintainer = 'BCURRAN3'
$softwareName   = 'Windows Driver Package - Era software*'
$installerType  = 'EXE'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://www.winflector.com/store/free-version/index/id/374' 
$checksum       = '0DFF1C631801C5463D3C1DFF40D95E782CA6A62F1C5D03B88696F663EF8E7DD8'
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
  checksumType  = 'sha256' 
}

Show-Patreon "https://www.patreon.com/bcurran3"
Install-ChocolateyPackage @packageArgs  
Show-ToastMessage "$packageName installed." "Version $env:packageVersion."
