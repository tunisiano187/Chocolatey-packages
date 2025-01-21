$ErrorActionPreference = 'Stop';
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = $env:ChocolateyPackageName
$url32          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.85/TrafficMonitor_V1.85_x86.zip'
$checksum32     = '899211D9B91993D7A1A89BFEF39B8AEFD3AB59F9F2EB10F8194E6CAEAA8404F8'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.85/TrafficMonitor_V1.85_x64.zip'
$checksum64     = 'E7BF816EFDEBF4F30A83AD9E7A85CD8C5C9FAC3C733864E954373ADD6E717317'
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
