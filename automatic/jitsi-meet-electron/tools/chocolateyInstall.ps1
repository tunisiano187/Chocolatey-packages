$ErrorActionPreference = 'Stop'


$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = "jitsi-meet-electron"
  file    = "$toolsdir\app-32.7z"
  file64  = "$toolsdir\app-64.7z"
  unzipLocation  = "$toolsDir"
  checksum       = '987400B0C926F9CA7C9C027624D952826741D414A08EECAD137B3AD78F0E555C'
  checksum64     = 'BFECCF4ED3F360A2B7944FB443064461244F3BCE658B8B8AF94D841A899B37A8'
  checksumType   = 'sha256'
  ChecksumType64 = 'sha256'
}


Write-Verbose "Unpacking"
Install-ChocolateyZipPackage @packageArgs

Get-ChildItem $toolsdir\*.7z | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }

Write-Verbose "Searching for exe"
$files = get-childitem "$toolsdir" -include "*.exe" -recurse


foreach ($file in $files) {
  #generate an ignore file
  if($file.Name -like "Jitsi*") {
    Write-Verbose "Crating Start Menu enty for $($file.BaseName)"
    $newlink ="$($env:ProgramData)\Microsoft\Windows\Start Menu\Programs\$($file.BaseName).lnk"
    Install-ChocolateyShortcut -shortcutFilePath $newlink  -targetPath "$file"
    Add-Content "$toolsdir\chocoUninstall.ps1" -Value "Remove-Item `"$($newlink)`" -Force -ea ignore"
  } else {
    Write-Verbose "Ignoring $($file.Name)"
    New-Item "$file.ignore" -type file -force | Out-Null
  }
}
