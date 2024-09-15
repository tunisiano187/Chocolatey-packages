$ErrorActionPreference = 'Stop'
$packageName   = 'feednotifier'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url           = "$toolsDir\feed-notifier-2.6.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $url
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  softwareName  = 'Feed Notifier*' 
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe -force | Out-Null
