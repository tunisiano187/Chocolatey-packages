$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortcutName = 'HBBatchBeast.lnk'
$exe          = "hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+"\hbbatchbeast.exe"

Remove-Item "$toolsDir\hbbatchbeast-Windows-v*" -Exclude *.7z -Recurse -EA SilentlyContinue

$packageArgs = @{
  packageName    = 'hbbatchbeast'
  UnzipLocation  = $toolsDir
  fileType       = 'ZIP' 
  file           = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+".7z"
  }

Install-ChocolateyZipPackage @packageArgs

$IgnoreFile = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+'\HandBrakeCLI.exe.ignore'
Echo "no shim" | Out-File -Encoding ASCII -FilePath $IgnoreFile
$IgnoreFile = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+'\hbbatchbeast.exe.ignore'
Echo "no shim" | Out-File -Encoding ASCII -FilePath $IgnoreFile
$IgnoreFile = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+'\resources\app.asar.unpacked\node_modules\@ffmpeg-installer\win32-x64\ffmpeg.exe.ignore'
Echo "no shim" | Out-File -Encoding ASCII -FilePath $IgnoreFile
$IgnoreFile = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+'\resources\app.asar.unpacked\node_modules\ffprobe-static\bin\win32\ia32\ffprobe.exe.ignore'
Echo "no shim" | Out-File -Encoding ASCII -FilePath $IgnoreFile
$IgnoreFile = "$toolsDir\hbbatchbeast-Windows-v"+"$env:ChocolateyPackageVersion"+'\resources\app.asar.unpacked\node_modules\ffprobe-static\bin\win32\x64\ffprobe.exe.ignore'
Echo "no shim" | Out-File -Encoding ASCII -FilePath $IgnoreFile

Remove-Item $toolsDir\*.7z -EA SilentlyContinue | Out-Null

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\$exe" -WorkingDirectory "$toolsDir\"
