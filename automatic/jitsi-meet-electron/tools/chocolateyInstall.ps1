$ErrorActionPreference = 'Stop'


$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = "jitsi-meet-electron"
  file    = "$toolsdir\app-32.7z"
  file64  = "$toolsdir\app-64.7z"
  unzipLocation  = "$toolsDir"
  checksum       = '8ABACBF9A2956855D44D838EBB58A9DE65153B1EED6E5827033D5E2991BA3B56'
  checksum64     = 'CAABD8997D0CD2312121DB8F888C4B13435568A49C6A523E07E4CF136C7104CA'
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
