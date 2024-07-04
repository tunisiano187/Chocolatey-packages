$packageName = 'mossawir-lan-messenger'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'https://downloads.sourceforge.net/project/mossawirlanmsg/MossawirLanMessenger3.exe'
$checksum    = 'E20BBC45AA7760E27176D3767F7B351D05B5639A753842B596EDC39FE70EDE93'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url           = $url
  silentArgs    = '/S'
  softwareName  = 'Mossawir LAN Messenger 3*'
  checksum      = $checksum
  checksumType  = 'sha256'
  }
Install-ChocolateyPackage @packageArgs
