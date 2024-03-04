$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = "quaternion"
  file           = "$toolsDir\quaternion_windows.zip"
  file64         = "$toolsDir\quaternion_windows.zip"
  destination    = "$toolsDir"
}

Get-ChocolateyUnzip @packageArgs

Remove-Item $toolsDir\*.zip -ea 0
