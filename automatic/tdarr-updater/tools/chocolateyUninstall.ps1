$ErrorActionPreference = 'Stop'
$packageName    = 'tdarr-updater'

Remove-Item "$env:ProgramFiles\Tdarr" -Recurse -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tdarr" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$env:Public\Desktop\Tdarr_Updater.lnk" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$env:Public\Desktop\Tdarr_Server.lnk" -Force -ErrorAction SilentlyContinue | Out-Null
Remove-Item "$env:Public\Desktop\Tdarr_Node.lnk" -Force -ErrorAction SilentlyContinue | Out-Null
