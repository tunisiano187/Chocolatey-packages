$ErrorActionPreference = 'Stop'
$packageName = 'take-command'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\tcmd.exe"
$MajorVer    = (Get-Item $url).VersionInfo.FileMajorPart

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  file         = $url
  silentArgs   = '/Q'
  softwareName = "Take Command $MajorVer"
  }
  
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url -Force -ErrorAction SilentlyContinue | Out-Null
