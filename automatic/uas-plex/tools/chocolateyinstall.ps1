$packageName      = 'uas-plex'
$BundleName       = 'WebTools.bundle'
$url              = 'https://github.com/ukdtom/WebTools.bundle/releases/download/3.0.0/WebTools.bundle.zip'
$checksum         = '5223623E85B67DA7B42E463CC5F344D45FC7A794E8540CEDC2047D931742E4C5'
$checksumType     = 'sha256'
$LocalAppDataPath = Get-ItemProperty -path "registry::hkey_current_user\software\Plex, Inc.\Plex Media Server" | select-object -expandproperty LocalAppDataPath


if ($null -eq $LocalAppDataPath) {
   Write-Information "Plex Media Server has not been configured yet!" -ForegroundColor red -BackgroundColor blue
   Write-Information "Creating default directories..."
   New-Item "$env:LOCALAPPDATA\Plex" -Type Directory -force
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server" -Type Directory -force
   New-Item "$env:LOCALAPPDATA\Plex\Plex Media Server\Plug-ins" -Type Directory -force
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
  Write-Information "Renaming previous version .old."
  Rename-Item "$UnZipDir\$BundleName" "$BundleName.old"
}Else{
  Write-Information "No previous version exists."
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

Write-Information "You can ignore Only an exit code of non-zero will fail... messages."
