$packageName  = 'startuplist.portable' 
$ExeFile      = 'StartupList.exe'
$ShortcutName = 'StartupList'

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "$ENV:ChocolateyInstall\lib\$packageName\tools\$ExeFile"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory "$toolsDir"