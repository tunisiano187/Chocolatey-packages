$ErrorActionPreference = 'Stop';
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = $env:ChocolateyPackageName
$url32          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.85.1/TrafficMonitor_V1.85.1_x86.zip'
$checksum32     = '94CAAFF95C94AD8C28D075DBB4E7D5947F8944D4A7B3BCB6EFFDCB0F47EE0B33'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.85.1/TrafficMonitor_V1.85.1_x64.zip'
$checksum64     = '8295236FCC9C62564130962005358E3F6B90135D56726F8034BB934562CEC58E'
$checksumType64 = 'sha256'

$shortcutsPath = [Environment]::GetFolderPath("Programs")

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = "$Env:LOCALAPPDATA\"
  url             = $url32
  Checksum        = $checksum32
  ChecksumType    = $checksumType32
  url64           = $url64
  Checksum64      = $checksum64
  ChecksumType64  = $checksumType64
  softwareName    = 'traffic-monitor*'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath (Join-Path -Path $shortcutsPath -ChildPath 'Traffic Monitor.lnk') -targetPath (Join-Path -Path "$Env:LOCALAPPDATA" -ChildPath 'TrafficMonitor\TrafficMonitor.exe')
