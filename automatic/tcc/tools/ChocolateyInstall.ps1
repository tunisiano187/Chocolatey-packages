$ErrorActionPreference = 'Stop'
$packageName = 'tcc'
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = "$toolsDir\tcc.exe"
$MajorVer    = (Get-Item $url).VersionInfo.FileMajorPart

$packageArgs = @{
  packageName  = $packageName
  fileType     = 'EXE'
  file         = $url
  silentArgs   = '/quiet'
  softwareName = "TCC $MajorVer"
  }

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $url -Force -ErrorAction SilentlyContinue | Out-Null
