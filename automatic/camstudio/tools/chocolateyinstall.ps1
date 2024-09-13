$ErrorActionPreference = 'Stop'
$packageName= 'camstudio' 
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://pilotfiber.dl.sourceforge.net/project/camstudio/stable/CamStudio_Setup_2-7_r316.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe' 
  url           = $url
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  softwareName  = 'CamStudio*' 
  checksum      = '370209DCB723B18A590430C9C8989F6ECBB2C563CDA97442EF74C7766F26FD3F'
  checksumType  = 'sha256'  
  }
Install-ChocolateyPackage @packageArgs
