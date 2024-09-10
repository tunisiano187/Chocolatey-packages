$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'atomicparsley'
  unzipLocation = $toolsDir
  FileFullPath  = "$toolsDir\AtomicParsleyWindows.zip"
}

Get-ChocolateyUnzip @packageArgs
Move-Item -Path "$toolsDir\Release\*.exe" -Destination "$toolsDir"
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue -Force | Out-Null
