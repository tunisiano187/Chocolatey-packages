$ErrorActionPreference = 'Stop'
$packageName= 'ost2pst-wizard'
$softwareName = 'OST2PST Wizard*'
$installerType = 'EXE'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://ost2pstware.com/dl/ost2pst-wizard.exe' 
$checksum   = '62D4DA4E230B18CDD3ABD17CF7A69AB82509485E4E90B32C8AF31CD19A07F7AB'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes= @(0, 3010, 1641)

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
  
