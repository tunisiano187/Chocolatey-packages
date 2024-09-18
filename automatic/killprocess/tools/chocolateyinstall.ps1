$ErrorActionPreference = 'Stop'
$packageName= 'killprocess'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://orangelampsoftware.com/downloads/KillProcess.exe'
$checksum   = '511B478937F6228678A6973F5ECBF6E87D45BB7FFC4A9D81225C715D366D6062'
$installerPackage = Join-Path $ToolsDir "KillProcess.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url           = $url
  FileFullPath  = $installerPackage
  checksum      = $checksum
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut -shortcutFilePath "$env:Public\Desktop\KillProcess.lnk" -targetPath "$toolsDir\KillProcess.exe" -WorkingDirectory "$toolsDir"
Install-ChocolateyShortcut -shortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\KillProcess.lnk" -targetPath "$toolsDir\KillProcess.exe"
