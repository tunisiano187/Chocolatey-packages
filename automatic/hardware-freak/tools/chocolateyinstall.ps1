$packageName= 'hardware-freak' 

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Hardware Freak.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\HardwareFreak.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Hardware Freak.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\HardwareFreak.exe"