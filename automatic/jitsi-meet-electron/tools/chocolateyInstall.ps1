$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$downtemp = Join-Path $toolsDir 'temp'

# Detecter l'architecture du systeme
$is64Bit = [Environment]::Is64BitOperatingSystem

Write-Verbose "Systeme detecte : $(if($is64Bit){'64 bits'}else{'32 bits'})"

# Nettoyer temp et creer dossier
Remove-Item $downtemp -Recurse -Force -ea Ignore
New-Item -ItemType Directory -Force -Path $downtemp | Out-Null

# Telecharger l'EXE SFX GitHub avec checksum
$packageArgs = @{
  packageName   = 'jitsi-meet-electron'
  fileFullPath  = "$downtemp\jitsi-meet.exe"
  url           = 'https://github.com/jitsi/jitsi-meet-electron/releases/download/v2026.5.0/jitsi-meet.exe'
  checksum      = 'DF5C5B439D97B08BE7DD14247C8AE91082ADC867AC6491AB3FDA914FD652427D'
  checksumType  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

# Extraire les .7z avec 7z
set-alias 7z "$env:ChocolateyInstall\tools\7z.exe"
7z x "$downtemp\jitsi-meet.exe" "-o$downtemp" -y

# Nettoyer anciens .7z et deplacer SEULEMENT la version necessaire
Remove-Item "$toolsDir\*.7z" -Force -ea Ignore
if ($is64Bit) {
  Move-Item "$downtemp\`$PLUGINSDIR\app-64.7z" "$toolsDir\" -Force
  $fileToExtract = "app-64.7z"
} else {
  Move-Item "$downtemp\`$PLUGINSDIR\app-32.7z" "$toolsDir\" -Force
  $fileToExtract = "app-32.7z"
}

# Nettoyer temp
Remove-Item $downtemp -Recurse -Force -ea Ignore

# Calculer checksum pour la version utilisee
$Algorithm = 'sha256'
$checksum = (Get-FileHash "$toolsDir\$fileToExtract" -Algorithm $Algorithm).Hash

# Extraire SEULEMENT la bonne version
Write-Verbose "Extraction de $fileToExtract"
Get-ChocolateyUnzip -fileFullPath "$toolsDir\$fileToExtract" -destination $toolsDir -checksum $checksum -checksumType $Algorithm

# Nettoyer le .7z apres extraction
Remove-Item "$toolsDir\$fileToExtract" -Force -ea Ignore
New-Item "$toolsDir\$fileToExtract.ignore" -type file -force | Out-Null

# Reste du script identique (raccourcis)
Write-Verbose "Searching for exe"
$files = Get-ChildItem "$toolsDir" -include "*.exe" -recurse

foreach ($file in $files) {
  if($file.Name -like "Jitsi*") {
    Write-Verbose "Creating Start Menu entry for $($file.BaseName)"
    $newlink = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\$($file.BaseName).lnk"
    Install-ChocolateyShortcut -shortcutFilePath $newlink -targetPath $file.FullName
    Add-Content "$toolsDir\chocolateyUninstall.ps1" -Value "Remove-Item `"$($newlink)`" -Force -ea ignore"
  } else {
    Write-Verbose "Ignoring $($file.Name)"
    New-Item "$($file.FullName).ignore" -type file -force | Out-Null
  }
}
