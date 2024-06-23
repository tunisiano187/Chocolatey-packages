$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-alpine'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits           = Get-ProcessorBits
$shortcutName   = 'Alpine.lnk'
$exe            = "$toolsDir\distro\launcher.exe"

if (!($bits -eq 64)){
    Write-Warning "  **  This package is for 64 bit versions of Windows only. Aborting..."
	throw
	}

$packageArgs = @{
  packageName    = $packageName
  softwareName   = ''
  fileType       = 'EXE'
  silentArgs     = 'install --root'
  file           = "$exe"
  validExitCodes = @(0,1)
  }

Install-ChocolateyInstallPackage @packageArgs

Install-BinFile -Name Alpine -Path $exe
Install-ChocolateyShortcut -shortcutFilePath "$ENV:Public\Desktop\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"
Install-ChocolateyShortcut -shortcutFilePath "$ENV:ProgramData\Microsoft\Windows\Start Menu\Programs\$shortcutName" -targetPath $exe -WorkingDirectory "$toolsDir\distro"

wslconfig /list
Write-Host "  ** To run Alpine Linux, type Alpine from the Command Prompt or PowerShell." -ForeGround Magenta

$WhoAmI=whoami
icacls.exe "$toolsDir\distro" /grant $WhoAmI":"'(OI)(CI)'F /T | Out-Null
