$ErrorActionPreference = 'Stop';

$shortcutsPath = [Environment]::GetFolderPath("Programs")

Remove-Item -Path (Join-Path -Path $shortcutsPath -ChildPath 'Traffic Monitor.lnk') -ErrorAction SilentlyContinue
Remove-Item -Path (Join-Path -Path "$Env:LOCALAPPDATA" -ChildPath "TrafficMonitor") -Recurse -Force -ErrorAction SilentlyContinue