$ErrorActionPreference = 'Stop'
$packageName= 'cdmessenger' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://www.cdmessenger.com/downloads/cdmsetup330.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'CDMessenger*' 
  checksum      = 'AE2923525C385A6D7E5A5DF8E5A8FA9383A0E5D018A5082DF36DBE0DC8F762B3'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
