$ErrorActionPreference = 'Stop'
$packageName  = $env:ChocolateyPackageName
$url          = 'https://d2j9xt6n9dg5d3.cloudfront.net/win/24780926_1c962c14fdc55b2e347aeb3c3ffc5ee6/AmazonMusicInstaller.exe'
$checksum     = ''
$checksumType = ''

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'Amazon Music'
  checksum      = $checksum
  checksumType  = $checksumType
  silentArgs    = '--unattendedmodeui none'
  validExitCodes= @(0)
}

Start-WaitandStop "Amazon Music Helper"
Start-WaitandStop "Amazon Music"
Install-ChocolateyPackage @packageArgs
