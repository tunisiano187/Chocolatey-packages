
$ErrorActionPreference = 'Stop';
$url            = 'https://clients.chime.aws/win/latest'
$checksum       = '239bcc76b695f4619488897982e7e659bbfbcf79c40644f2c39826c363990b08'
$checksumType   = 'sha256'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'amazon-chime*'

  checksum      = $checksum
  checksumType  = $checksumType

  silentArgs    = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
