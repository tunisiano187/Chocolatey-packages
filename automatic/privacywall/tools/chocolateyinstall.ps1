$ErrorActionPreference = 'Stop'; # stop on all errors

$url          = 'https://cdn.privacywall.org/pro/PrivacyWallFirewallProSetup.exe'
$checksum     = 'fa02a3bacf22735805c512b18a441f559b0c53e9ebf75f80b48c5cba779708eb'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'privacywall*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
