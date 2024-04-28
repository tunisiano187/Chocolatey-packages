$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  FileFullPath64 = Get-Item $toolsPath\*_x64.zip
  Destination    = $toolsPath
}

#Get-ChildItem $toolsPath\* | Where-Object { $_.PSISContainer } | Remove-Item -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
Remove-Item $toolsPath\*.zip -ea 0

$startupPath = [Environment]::GetFolderPath("Startup")
$startMenuPath = [Environment]::GetFolderPath("CommonPrograms")

if(Test-Path -Path "$startupPath\$env:ChocolateyPackageName.lnk") {
    Install-ChocolateyShortcut `
        -ShortcutFilePath "$startupPath\$env:ChocolateyPackageName.lnk" `
        -TargetPath "$env:ChocolateyInstall\bin\$env:ChocolateyPackageTitle.exe"
}

Install-ChocolateyShortcut `
  -ShortcutFilePath "$startMenuPath\$env:ChocolateyPackageName.lnk" `
  -TargetPath "$env:ChocolateyInstall\bin\$env:ChocolateyPackageTitle.exe"
