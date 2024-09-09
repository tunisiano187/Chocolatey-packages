#https://www.videolan.org/vlc/download-skins2-go.php?url=vlc-skins.zip
$packageName    = 'vlc-skins'
$installerType  = 'zip'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file           = "$toolsDir\vlc-skins.zip"
$unzipLocation  = ${env:ProgramFiles} + '\VideoLAN\VLC\skins'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzipLocation
  fileType      = $installerType
  file          = $file
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $url

