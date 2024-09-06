#https://www.videolan.org/vlc/download-skins2-go.php?url=vlc-skins.zip
$packageName    = 'vlc-skins'
$installerType  = 'zip'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = "$toolsDir\vlc-skins.zip"
$checksum       = 'AF5A3ABE17BBB67FB3B07D0300A88C403AF66B9A2917AA4F3B2321892E56AB2C'
$checksumType   = 'sha256'
$unzipLocation  = ${env:ProgramFiles} + '\VideoLAN\VLC\skins'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzipLocation
  fileType      = $installerType
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $url 
				  