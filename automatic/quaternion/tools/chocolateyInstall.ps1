$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file = "$toolsDir\quaternion_windows.zip"

$packageArgs = @{
  packageName    = "quaternion"
  file           = "$toolsDir\quaternion_windows.zip"
  destination    = "$toolsDir"
}

Expand-Archive -Path $file -DestinationPath $toolsDir

#Remove-Item $toolsDir\*.zip -ea 0
