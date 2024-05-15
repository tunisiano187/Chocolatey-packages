$ErrorActionPreference = 'Stop'
$packageName      = 'tdarr-updater'
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $packageName
  Destination    = "$env:ProgramFiles\Tdarr"
  FileFullPath   = "$toolsDir\Tdarr_Updater.zip"
}

Get-ChocolateyUnzip @packageArgs

Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null

Start-ChocolateyProcessAsAdmin -ExeToRun "$env:ProgramFiles\Tdarr\Tdarr_Updater.exe"

Get-ChildItem -Path $env:ProgramFiles\Tdarr -Recurse | Where-Object {
  $_.Extension -eq '.exe'
} | ForEach-Object {
  New-Item $($_.FullName + '.ignore') -Force -ItemType file
} | Out-Null

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Tdarr_Updater.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Updater.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tdarr\Tdarr_Updater.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Updater.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Tdarr_Server.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Server\Tdarr_Server.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr\Tdarr_Server" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tdarr\Tdarr_Server.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Server\Tdarr_Server.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr\Tdarr_Server" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Tdarr_Node.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Node\Tdarr_Node.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr\Tdarr_Node" -RunAsAdmin
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Tdarr\Tdarr_Node.lnk" -targetPath "$env:ProgramFiles\Tdarr\Tdarr_Node\Tdarr_Node.exe" -WorkingDirectory "$env:ProgramFiles\Tdarr\Tdarr_Node" -RunAsAdmin

