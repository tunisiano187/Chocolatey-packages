$packageName    = 'tonido-sync'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://patch.codelathe.com/tonido/live/installer/x86-win32/TonidoSync2Setup.exe' 
$checksum       = 'EE0981B6ED53BB809323AABEF3DBF77D1668D5727004341212D2033685117373'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
$validExitCodes = @(0) 

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  silentArgs    = $silentArgs  
  validExitCodes= $validExitCodes
  softwareName  = 'TonidoSync2 *'
  checksum      = $checksum
  checksumType  = 'sha256'   
}

Install-ChocolateyPackage @packageArgs
