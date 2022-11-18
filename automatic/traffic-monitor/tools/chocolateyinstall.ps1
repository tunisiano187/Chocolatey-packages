$ErrorActionPreference = 'Stop';
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = $env:ChocolateyPackageName
$url32          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.84.1/TrafficMonitor_V1.84.1_x86.zip'
$checksum32     = '47C95D4BB315FC89353EC6F84FFF31760C3C609282B076F9082E1AE37E86D9DC'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.84.1/TrafficMonitor_V1.84.1_x64.zip'
$checksum64     = '7217C298D56936C58E36F8B98FCEA50537AE935D57BC85C946C6385B6FFDD7CC'
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
