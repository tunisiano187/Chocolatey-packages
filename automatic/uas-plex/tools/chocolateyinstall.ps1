$packageName      = 'uas-plex'
$BundleName       = 'WebTools.bundle'
$url              = 'https://github.com/ukdtom/WebTools.bundle/releases/download/2.4.1/WebTools.bundle.zip'
$checksum         = '4289A1973508CC77578D64220FE728A4FD0BA15B6D8478632C5DE1EAD5C80C75'
$checksumType     = 'sha256'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath


if ($null -eq $LocalAppDataPath) {
   Write-Information "Plex Media Server has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   Write-Information "Creating default directories..." -ForegroundColor green -BackgroundColor blue
   New-Item "$env:LOCALAPPDATA\Plex" -Type Directory -force
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server" -Type Directory -force
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server\Plug-ins" -Type Directory -force
   $LocalAppDataPath = "$env:LOCALAPPDATA\Plex"
  }
$UnZipDir         = Join-Path -Path $LocalAppDataPath -ChildPath "Plex Media Server\Plug-ins"

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName.old"
If (Test-Path $strFileName){
  Write-Information "Removing previous .old version." -ForegroundColor green -BackgroundColor blue
  Remove-Item "$UnZipDir\$BundleName.old" -recurse
}Else{
  Write-Information ".old version does not exist." -ForegroundColor green -BackgroundColor blue
}

$strFileName="$LocalAppDataPath\Plex Media Server\Plug-ins\$BundleName"
If (Test-Path $strFileName){
  Write-Information "Renaming previous version .old." -ForegroundColor green -BackgroundColor blue
  Rename-Item "$UnZipDir\$BundleName" "$BundleName.old"
}Else{
  Write-Information "No previous version exists." -ForegroundColor green -BackgroundColor blue
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $UnZipDir
  fileType      = 'ZIP'
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Write-Information "You can ignore Only an exit code of non-zero will fail... messages." -ForegroundColor green -BackgroundColor blue
