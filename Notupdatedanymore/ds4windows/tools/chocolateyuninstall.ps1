$startupPath = [Environment]::GetFolderPath("Startup")
$startMenuPath = [Environment]::GetFolderPath("CommonPrograms")

Remove-Item "$startupPath\$env:ChocolateyPackageName.lnk" -ErrorAction SilentlyContinue -Force
Remove-Item "$startMenuPath\$env:ChocolateyPackageName.lnk" -ErrorAction SilentlyContinue -Force
