$ErrorActionPreference = 'Stop'
$packageName  = 'tautulli' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file         = "$toolsDir\Tautulli-"+$ENV:ChocolateyPackageVersion+".zip"
$extractDir   = "Tautulli-"+$ENV:ChocolateyPackageVersion
$shortcutName = 'Tautulli.lnk'

Get-ChocolateyUnzip -FileFullPath $file -Destination $toolsDir

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$extractDir\Tautulli.py" -WorkingDirectory "$toolsDir\$extractDir" -IconLocation "$toolsDir\$extractDir\data\interfaces\default\images\favicon\favicon.ico"

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
