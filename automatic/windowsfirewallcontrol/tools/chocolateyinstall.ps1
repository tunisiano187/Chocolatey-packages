$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://www.binisoft.org/download/wfc6setup.exe'
$checksum       = '17f2ebeed6e36c0475ff1ba39417c31acb8ad71ea5df8a2e3de61cb9f0e03b81'
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
