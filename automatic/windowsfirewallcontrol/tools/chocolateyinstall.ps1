$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://www.binisoft.org/download/wfc6setup.exe'
$checksum       = 'cf5ec3ba3ca300bc4bb844446e26c4b921cf1097c7c387b37a8c23df37dfcf31'
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
