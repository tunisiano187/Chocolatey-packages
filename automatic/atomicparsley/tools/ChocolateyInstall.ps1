$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'atomicparsley'
  unzipLocation = "$toolsDir\Release"
  FileFullPath  = "$toolsDir\AtomicParsleyWindows.zip"
}

Get-ChocolateyUnzip @packageArgs
Move-Item -Path "$toolsDir\Release\*.exe" -Destination "$toolsDir"
Remove-Item "$toolsDir\Release" -ErrorAction SilentlyContinue -Force | Out-Null
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue -Force | Out-Null
