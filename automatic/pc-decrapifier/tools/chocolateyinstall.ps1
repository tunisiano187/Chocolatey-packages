$ErrorActionPreference = 'Stop'
$packageName='pc-decrapifier'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://s3.amazonaws.com/dl.pcdecrapifier.com/pc-decrapifier-3.0.1.exe'
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
$installerPackage = Join-Path $scriptDir "pc-decrapifier-3.0.1.exe";

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  softwareName  = ''
  checksum      = 'FEB352471748F445CBA237FD4188C6E8D996D9318358D1FCEA4EAF90018253D1'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\The PC Decrapifier.lnk" -targetPath "$env:ChocolateyInstall\lib\pc-decrapifier\tools\pc-decrapifier-3.0.1.exe"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\The PC Decrapifier.lnk" -targetPath "$env:ChocolateyInstall\lib\pc-decrapifier\tools\pc-decrapifier-3.0.1.exe"














