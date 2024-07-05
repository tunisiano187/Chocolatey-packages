$ErrorActionPreference = 'Stop'

# Uninstall glassfish server
$regeditItem 		= 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\nbi-glassfish*'
$UninstallProperty 	= Get-ItemProperty -Path $regeditItem -Name 'UninstallString'

$packageName  	= 'glassfish'
$fileType     	= 'EXE'
$silentArgs   	= '--silent'
$uninstallPath	= $UninstallProperty.UninstallString

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -File $uninstallPath -ValidExitCodes @(0)

# Uninstall Netbeans
$regeditItem 		= 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\nbi-nb-base*'
$UninstallProperty	= Get-ItemProperty -Path $regeditItem -Name 'UninstallString'

$packageName  	= 'netbeans'
$fileType     	= 'EXE'
$silentArgs   	= '--silent'
$uninstallPath	= $UninstallProperty.UninstallString

Uninstall-ChocolateyPackage -PackageName $packageName -FileType $fileType -SilentArgs $silentArgs -File $uninstallPath -ValidExitCodes @(0)