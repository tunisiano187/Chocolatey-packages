$ErrorActionPreference = 'Stop';
$url          = 'https://www.voicemod.net/b2c/v2/VoicemodSetup_2.2.0.2.exe'
$checksum     = 'fe984cfe417284c42168e5a55762621818e8f66f84cce571e2a83ae9f40ad268'
$checksumType = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'voicemod*'

  checksum      = $checksum
  checksumType  = $checksumType

  validExitCodes= @(0, 3010, 1641)
  silentArgs   = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' # Inno Setup
}

Install-ChocolateyPackage @packageArgs
