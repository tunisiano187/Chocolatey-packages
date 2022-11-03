$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = $env:ChocolateyPackageName
$url32          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.84/TrafficMonitor_V1.84_x86.zip'
$checksum32     = ''
$checksumType32 = ''
$url64          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.84/TrafficMonitor_V1.84_x64.zip'
$checksum64     = ''
$checksumType64 = ''

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
