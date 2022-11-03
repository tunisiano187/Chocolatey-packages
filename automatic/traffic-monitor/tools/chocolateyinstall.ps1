$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = $env:ChocolateyPackageName
$fileName32 = 'TrafficMonitor_V1.83_x86.zip'
$fileName64 = 'TrafficMonitor_V1.83_x64.zip'


$shortcutsPath = [Environment]::GetFolderPath("Programs")

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = "$Env:LOCALAPPDATA\"
  file          = "$toolsDir\$fileName32"
  file64        = "$toolsDir\$fileName64"
  url64bit      = $url64
  softwareName  = 'traffic-monitor*'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath (Join-Path -Path $shortcutsPath -ChildPath 'Traffic Monitor.lnk') -targetPath (Join-Path -Path "$Env:LOCALAPPDATA" -ChildPath 'TrafficMonitor\TrafficMonitor.exe')
