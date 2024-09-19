$ErrorActionPreference = 'Stop'
$packageName = 'kmttg' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Get-ChocolateyUnzip -FileFullPath "$toolsDir\kmttg_v2.4p.zip" -Destination "$toolsDir"

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\kmttg.lnk" -targetPath "$toolsDir\kmttg.jar" -WorkingDirectory "$toolsDir" -IconLocation "$toolsDir\kmttg.ico"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\kmttg.lnk" -targetPath "$toolsDir\kmttg.jar" -WorkingDirectory "$toolsDir" -IconLocation "$toolsDir\kmttg.ico"

Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
