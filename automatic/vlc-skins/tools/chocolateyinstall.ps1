#https://www.videolan.org/vlc/download-skins2-go.php?url=vlc-skins.zip
$packageName    = 'vlc-skins'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file           = "$toolsDir\vlc-skins.zip"
$unzipLocation  = ${env:ProgramFiles} + '\VideoLAN\VLC\skins'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $unzipLocation
  FileFullPath  = $file
}

Get-ChocolateyUnzip @packageArgs

Remove-Item $url

