$uninstaller = $(./Get-InstalledApps.ps1 -NameRegex Fing).UninstallString.split('"')[1]
Start-Process -FilePath $uninstaller -ArgumentList "/allusers /S"