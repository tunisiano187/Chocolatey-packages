$ErrorActionPreference = 'Stop'
$packageName  = 'beebeep'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipDir     = "beebeep-" + "$ENV:ChocolateyPackageVersion" + "-32bit-portable"
$ShortcutName = 'beeBEEP'
$exe          = 'beeBEEP.exe'

$packageArgs = @{
  packageName    = $packageName
  Destination    = $toolsDir
  FileFullPath   = "$toolsDir\beebeep-" + "$ENV:ChocolateyPackageVersion" + "-32bit-portable.zip"
}

Get-ChocolateyUnzip @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$ShortcutName.lnk" -targetPath "$toolsDir\$unzipDir\$exe" -WorkingDirectory "$toolsDir\$unzipDir"

Remove-Item $toolsDir\*.zip -Force -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS:
# Replace ZIP with current version
