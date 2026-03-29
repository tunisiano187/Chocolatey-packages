$ErrorActionPreference = 'Stop';
#$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName    = $env:ChocolateyPackageName
$url32          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.86/TrafficMonitor_V1.86_x86.zip'
$checksum32     = '2DDDBD07F54607035F7B54D15EF2597844335EE343AFE5F9DDB004E7F0725F04'
$checksumType32 = 'sha256'
$url64          = 'https://github.com/zhongyang219/TrafficMonitor/releases/download/V1.86/TrafficMonitor_V1.86_x64.zip'
$checksum64     = '948DDC12CC582E8CF0B7B32E0064544F6F711265A7671C2E47343A6A0FF4908E'
$checksumType64 = 'sha256'

$shortcutsPath = [Environment]::GetFolderPath("Programs")

$unzip_location = "$Env:LOCALAPPDATA\"

$pp = Get-PackageParameters
if ($pp.unzipLocation) {
    $unzip_location = $pp.unzipLocation
    Write-Output "Param: Unzipping (installing) to $unzip_location"
}

$packageArgs = @{
  packageName     = $packageName
  unzipLocation   = $unzip_location
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
