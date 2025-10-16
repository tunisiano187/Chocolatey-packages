$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = 'https://www.binisoft.org/download/wfc6setup.exe'
$checksum       = '27403f34ddb154ef4eb56a0a4b2dff708759e5b341f469b519cd61110b112182'
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
