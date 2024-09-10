$ErrorActionPreference = 'Stop'
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = 'atomicparsley'
  unzipLocation = $toolsDir
  FileFullPath  = "$toolsDir\AtomicParsleyWindows.zip"
}

Get-ChocolateyUnzip @packageArgs
Move-Item -Path "$toolsDir\Release\*.exe" -Destination "$toolsDir"
if(Test-Path "$toolsDir\Release") {
  Remove-Item "$toolsDir\Release" -ErrorAction SilentlyContinue -Force | Out-Null
}
Remove-Item "$toolsDir\*.zip" -ErrorAction SilentlyContinue -Force | Out-Null
