$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://www.binisoft.org/download/wfc6setup.exe'
$checksum       = '464bd94bc3f74396e33d3052f597ddd2d083d057c1bfd7f2635aed4db8c99ec7'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'exe'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
  File          = "$toolsDir\wfcsetup.exe"
  silentArgs    = '-i -c'
  validExitCodes= @(0)
  softwareName  = 'Malwarebytes Windows Firewall Control*'
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key -and $key.Count -ge 1) {
    $packageArgs['silentArgs'] = '-u -c'
}

Install-ChocolateyPackage @packageArgs
