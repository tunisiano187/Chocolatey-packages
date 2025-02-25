$ErrorActionPreference = 'Stop';
$url          = 'https://github.com/LAB02-Research/HASS.Agent/releases/download/2022.14.0/HASS.Agent.Installer.exe'
$checksumType = 'sha256'
$checksum     = '7891381611435f304be5f303032788f87b4e6696ba0bda42c242d46dc5916134'

$packageArgs = @{
  packageName     = $env:ChocolateyPackageName
  fileType		    = "exe"

  url             = $url
  checksum        = $checksum
  checksumType    = $checksumType

  silentArgs	    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
}

Install-ChocolateyPackage @packageArgs
