$ErrorActionPreference = 'Stop';
$url          = 'https://github.com/hass-agent/HASS.Agent/releases/download/2.1.1/HASS.Agent.Installer.exe'
$checksumType = 'sha256'
$checksum     = '19c96bba6dda99e596c05f55b7b6499aa5af3f3769a530f48c22cea87034a364'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  silentArgs	    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs
