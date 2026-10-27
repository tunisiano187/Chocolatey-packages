$ErrorActionPreference = 'Stop'
$packageName = 'tdarr-updater'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = "$env:ProgramFiles\Tdarr"
  url           = 'https://storage.tdarr.io/versions/3.04.00/win32_x64/Tdarr_Updater.zip'
  checksum      = '80A81A2F9D805E0ABC01A82FAD3EC4EC127243C7AFC7E43488052BA4838FDA68'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

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
