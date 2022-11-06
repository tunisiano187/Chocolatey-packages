$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition


$packageArgs = @{
  PackageName    = $env:ChocolateyPackageName
  FileFullPath64 = gi $toolsPath\*_x64.zip
  Destination    = $toolsPath
}

ls $toolsPath\* | ? { $_.PSISContainer } | rm -Recurse -Force #remove older package dirs
Get-ChocolateyUnzip @packageArgs
rm $toolsPath\*.zip -ea 0

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
