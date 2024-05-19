$ErrorActionPreference = 'Stop'
# https://aka.ms/wsl-debian-gnulinux
$packageName    = 'wsl-debiangnulinux'
$bits           = Get-ProcessorBits
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$unzipLocation  = "$toolsDir\unzipped"
$shortcutName   = 'Debian.lnk'
$exe            = "debian.exe"
$appx           = (Get-ChildItem -Path $toolsDir -Filter "x64.appx").Name

if (!($bits -eq 64)){
    Write-Host "  **  This package is for 64 bit versions of Windows only. Aborting..." -Foreground Red
	throw
}

New-Item $unzipLocation -type directory -Force | Out-Null
New-Item "$toolsDir\distro" -type directory -Force | Out-Null

function Remove-UnnecessaryFiles{
 Remove-Item "$toolsDir\*.AppxBundle" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\unzipped" -Force -Recurse -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\AppxMetadata" -Recurse -Force  -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\Assets" -Recurse -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.gz" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.p7x" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.pri" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\*.xml" -Force -EA SilentlyContinue | Out-Null
 Remove-Item "$toolsDir\distro\debian.exe.ignore" -Force -EA SilentlyContinue | Out-Null
 }

Get-ChocolateyUnzip -FileFullPath "$toolsDir\*.AppxBundle" -Destination "$unzipLocation"
$Upgrade = (Test-Path "$ENV:ChocolateyInstall\lib\$packageName\tools\distro\$exe")

if ($Upgrade){
	Get-ChocolateyUnzip -FileFullPath "$unzipLocation\$appx" -Destination "$unzipLocation"
    Write-Host "  ** Existing version of Debian found." -Foreground Magenta
    Write-Host "  ** Upgrading launcher and system packages." -Foreground Magenta
	Copy-Item "$unzipLocation\$exe" to "$toolsDir\distro" -Force
    Set-Location $ChocolateyInstall\lib\$packageName\tools\distro
	debian run apt update
	debian run apt upgrade
    Remove-UnnecessaryFiles
    return
}

Get-ChocolateyUnzip -FileFullPath "$unzipLocation\$appx" -Destination "$toolsDir\distro"

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$toolsDir\distro\$exe"
  validExitCodes = @(0,1)
  }

Install-ChocolateyInstallPackage @packageArgs
wslconfig /list

Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath "$toolsDir\distro\$exe" -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath "$toolsDir\distro\$exe" -WorkingDirectory "$toolsDir\distro"
Remove-UnnecessaryFiles
$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null