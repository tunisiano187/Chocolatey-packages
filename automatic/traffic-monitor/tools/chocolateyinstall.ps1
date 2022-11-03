$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = $env:ChocolateyPackageName
$fileName32 = $(Get-ChildItem -Path $toolsDir -Include "x86.zip").FullName
$fileName64 = $(Get-ChildItem -Path $toolsDir -Include "x64.zip").FullName


$shortcutsPath = [Environment]::GetFolderPath("Programs")

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = "$Env:LOCALAPPDATA\"
  file          = "$fileName32"
  file64        = "$fileName64"
  url64bit      = $url64
  softwareName  = 'traffic-monitor*'
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut -shortcutFilePath (Join-Path -Path $shortcutsPath -ChildPath 'Traffic Monitor.lnk') -targetPath (Join-Path -Path "$Env:LOCALAPPDATA" -ChildPath 'TrafficMonitor\TrafficMonitor.exe')
