$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$downtemp = Join-Path $toolsDir 'temp'

# Détecter l'architecture du système
$is64Bit = [Environment]::Is64BitOperatingSystem

Write-Verbose "Système détecté : $(if($is64Bit){'64 bits'}else{'32 bits'})"

# Nettoyer temp et créer dossier
Remove-Item $downtemp -Recurse -Force -ea Ignore
New-Item -ItemType Directory -Force -Path $downtemp | Out-Null

# Télécharger l'EXE SFX GitHub avec checksum
$packageArgs = @{
  packageName   = 'jitsi-meet-electron'
  fileFullPath  = "$downtemp\jitsi-meet.exe"
  url           = 'https://release-assets.githubusercontent.com/github-production-release-asset/76293911/e0861e35-b00a-4b3e-a6ce-b6ac1b502f62?sp=r&sv=2018-11-09&sr=b&spr=https&se=2025-12-15T17%3A06%3A08Z&rscd=attachment%3B+filename%3Djitsi-meet.exe&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2025-12-15T16%3A05%3A50Z&ske=2025-12-15T17%3A06%3A08Z&sks=b&skv=2018-11-09&sig=A1HMcRgT8P7cczh2FhPq7%2BT8kuY4ceqLankn55OmWLA%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc2NTgxOTU1OCwibmJmIjoxNzY1ODE1OTU4LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.s_SxjHbnoXj81osnWwwu9wEUqCePPiqoa5Lyspq1xIo&response-content-disposition=attachment%3B%20filename%3Djitsi-meet.exe&response-content-type=application%2Foctet-stream'
  checksum      = '1ae9c39c0177d504c88b9021762f5a9e719240538f8fdfdf4e67c22bbcc17803'
  checksumType  = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

# Extraire les .7z avec 7z
set-alias 7z "$env:ChocolateyInstall\tools\7z.exe"
7z x "$downtemp\jitsi-meet.exe" "-o$downtemp" -y

# Nettoyer anciens .7z et déplacer SEULEMENT la version nécessaire
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

# Calculer checksum pour la version utilisée
$Algorithm = 'sha256'
$checksum = (Get-FileHash "$toolsDir\$fileToExtract" -Algorithm $Algorithm).Hash

# Extraire SEULEMENT la bonne version
Write-Verbose "Extraction de $fileToExtract"
Get-ChocolateyUnzip -fileFullPath "$toolsDir\$fileToExtract" -destination $toolsDir -checksum $checksum -checksumType $Algorithm

# Nettoyer le .7z après extraction
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
