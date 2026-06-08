$ErrorActionPreference = 'Stop';
$url          = 'https://github.com/hass-agent/HASS.Agent/releases/download/2.2.1/HASS.Agent.Installer.exe'
$checksumType = 'sha256'
$checksum     = '85eb36bbf8e0f428bdb5c689cd8b53def69315af32b24cf867d46fe7c1b5ee55'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  silentArgs	    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
}

Install-ChocolateyPackage @packageArgs
