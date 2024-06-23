$ErrorActionPreference = 'Stop'
$packageName = 'ammyy-admin' 

#Start-CheckandStop "AA_v3" 
#- if running, Chocolatey can't move to lib-bkp and will fail install before getting here since this is portable

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Ammyy Admin.lnk" -targetPath "$env:ChocolateyInstall\lib\$packageName\tools\AA_v3.exe"

#if ($ProcessWasRunning -eq "True") {&"$ProcessFullPath"}
