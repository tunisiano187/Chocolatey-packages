$ErrorActionPreference = 'Stop'
$packageName  = 'tageditor' 
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits         = Get-ProcessorBits
$shortcutName = 'Tag Editor.lnk'

Remove-Item "$toolsDir\*.exe" -Force -ErrorAction SilentlyContinue | Out-Null

Get-ChocolateyUnzip -FileFullPath "$toolsDir\*.zip" -Destination $toolsDir

if ($bits -eq 64)
   {
	$exeTarget = "tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe"
	Install-BinFile -Name tageditor -Path "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32-cli.exe"
	Write-Host "" | Out-File "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe.ignore"
	Write-Host "" | Out-File "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32-cli.exe.ignore"
	Remove-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe"
   } else {
	$exeTarget = "tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe"
	Install-BinFile -Name tageditor -Path "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32-cli.exe"
	Write-Host "" | Out-File "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32.exe.ignore"
	Write-Host "" | Out-File "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-x86_64-w64-mingw32-cli.exe.ignore"
	Remove-Item "$toolsDir\tageditor-$ENV:ChocolateyPackageVersion-i686-w64-mingw32.exe"
   }

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exeTarget" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exeTarget" -WorkingDirectory "$toolsDir\"

Remove-Item $toolsDir\*.zip -Force | Out-Null

# UPDATE INSTRUCTIONS:
# https://github.com/Martchus/tageditor/releases
# Replace ZIPs with current versions
