$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = ''
$checksum       = ''
$checksumType   = ''

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
if ($key.Count -gt 1) {
    $packageArgs['silentArgs'] = '-u -c'
}

Install-ChocolateyPackage @packageArgs
