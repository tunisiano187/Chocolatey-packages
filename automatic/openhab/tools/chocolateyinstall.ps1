$ErrorActionPreference = 'Stop'
$packageName   = 'openhab' 
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ExeFile       = 'start.bat'
$ShortcutName  = 'openHAB.lnk'
$ShortcutName2 = 'openHAB Dashboard.lnk'
$ShortcutName3 = 'openHAB Configuration Folder.lnk'
$ShortcutName4 = 'openHAB Documentation.lnk'
$ShortcutName5 = 'openHAB Community.lnk'
$ShortcutName6 = 'openHAB Console.lnk'
$ShortcutName7 = 'openHAB Logs.lnk'

if (!($env:JAVA_HOME)) {
    Write-Warning "  ** JAVA_HOME enviromental variable not set. You should set this."
   } else {
     if (!(Test-Path $env:JAVA_HOME)){
         Write-Warning "  ** JAVA_HOME is set to $env:JAVA_HOME but $env:JAVA_HOME does not exist."
        }
	}

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\openhab-$env:ChocolateyPackageVersion.zip"
}

Get-ChocolateyUnzip @packageArgs

New-Item "$toolsDir\openHAB" -type directory -force -ErrorAction SilentlyContinue
Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$ShortcutName" -targetPath "$toolsDir\openHAB" -WorkingDirectory "$toolsDir\openHAB" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName" -targetPath "$toolsDir\openHAB" -WorkingDirectory "$toolsDir\openHAB" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName" -targetPath "$toolsDir\$ExeFile" -WorkingDirectory $toolsDir -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName2" -targetPath "http://localhost:8080" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName3" -targetPath "$toolsDir\conf" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName4" -targetPath "http://docs.openhab.org/" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName5" -targetPath "https://community.openhab.org/" -IconLocation "$toolsDir\openHAB.ico"
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName6" -targetPath "$toolsDir\runtime\bin\client.bat" -WorkingDirectory "$toolsDir\runtime\bin" -IconLocation "$toolsDir\openHAB.ico"
New-Item "$toolsDir\userdata\logs" -ItemType Directory -EA SilentlyContinue
Install-ChocolateyShortcut -shortcutFilePath "$toolsDir\openHAB\$ShortcutName7" -targetPath "$toolsDir\userdata\logs" -IconLocation "$toolsDir\openHAB.ico" 

$WhoAmI=whoami
icacls.exe $toolsDir /grant $WhoAmI":"'(OI)(CI)'F /T | out-null
Remove-Item $toolsDir\openhab-*.zip -Force | Out-Null
