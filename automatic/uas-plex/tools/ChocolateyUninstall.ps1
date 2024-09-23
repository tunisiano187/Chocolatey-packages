$packageName      = 'uas-plex'
$BundleName       = 'WebTools.bundle'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath


if ($null -eq $LocalAppDataPath) {
   Write-Information "Plex Media Server has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
$UnZipDir         = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Information "Removing previous .old version."
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
}Else{
  Write-Information ".old version does not exist."
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Information "Removing $packageName"
  Remove-Item "$UnZipDir\$BundleName" -recurse
}Else{
  Write-Information "ERROR: No previous version exists."
}
  Write-Information "You can ignore Only an exit code of non-zero will fail... messages."

