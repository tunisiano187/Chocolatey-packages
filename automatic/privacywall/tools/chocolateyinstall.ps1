$ErrorActionPreference = 'Stop'; # stop on all errors

$url          = 'https://cdn.privacywall.org/pro/PrivacyWallFirewallProSetup.exe'
$checksum     = '6fcf264992a22f6d3bdce3919410fb1a1be2fc2076f14be78ad1c34e96dde1cc'
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
