$packageName    = 'tonido'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://patch.codelathe.com/tonido/live/installer/x86-win32/TonidoLiteSetup.exe' 
$checksum       = 'F2720E8F42CA3F5B1840D7EBFBDEEBE60F24843D588DE74D75ED631E7DFB5588'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes
  softwareName  = 'Tonido *'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
