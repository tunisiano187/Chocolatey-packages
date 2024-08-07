$ErrorActionPreference = 'Stop'
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\Trojan Remover\unins000.exe"
  } else {
  $unpath = "${Env:ProgramFiles}\Trojan Remover\unins000.exe"
  }
$packageName = 'trojan-remover'
$softwareName = 'Trojan Remover*'
$installerType = 'EXE'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
