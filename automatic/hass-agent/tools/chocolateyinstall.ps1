$ErrorActionPreference = 'Stop';
$url          = 'https://github.com/hass-agent/HASS.Agent/releases/download/2.2.0/HASS.Agent.Installer.exe'
$checksumType = 'sha256'
$checksum     = 'e389afc3939f1d5470f17a002a029b09124505e55058e895f460f6d34cc5d770'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  silentArgs	    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
}

Install-ChocolateyPackage @packageArgs
