$ErrorActionPreference = 'Stop'
$packageName = 'amazon-music'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://amazon.com/images/G/01/digital/music/morpho/installers/20200905/0031046272/AmazonMusicInstaller.exe' 
$checksum    = '73A2946C961D01B23FCE6BFF0FA26B71D47F00CFF32B7C7BB2BED3ABD72AA2E4'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE' 
  url           = $url
  softwareName  = 'Amazon Music' 
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '--unattendedmodeui none'
  validExitCodes= @(0)
}

Start-WaitandStop "Amazon Music Helper"
Start-WaitandStop "Amazon Music"
Install-ChocolateyPackage @packageArgs 
