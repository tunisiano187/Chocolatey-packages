$ErrorActionPreference = 'Stop'
$packageName  = $env:ChocolateyPackageName
$url          = 'https://download.sysinternals.com/files/Autoruns.zip'
$checksum     = 'REPLACEME'
$checksumType = 'sha256'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

# Accept EULA silently via registry
$regRoot = 'HKCU:\Software\Sysinternals\AutoRuns'
if (!(Test-Path $regRoot)) { New-Item -Path $regRoot -Force | Out-Null }
Set-ItemProperty -Path $regRoot -Name 'EulaAccepted' -Value 1 -Type DWord

# Create Start Menu shortcut
$programs      = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$shortcutPath  = Join-Path $programs 'Autoruns.lnk'
$targetPath    = Join-Path $toolsDir 'Autoruns.exe'
Install-ChocolateyShortcut -ShortcutFilePath $shortcutPath -TargetPath $targetPath
