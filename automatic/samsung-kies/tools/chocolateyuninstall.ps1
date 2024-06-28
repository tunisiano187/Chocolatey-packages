$packageName= 'samsung-kies'
$softwareName = 'Samsung Kies3*' 
$installerType = 'EXE' 
$silentArgs = '/S /v /qn /removeonly' 
$validExitCodes = @(0)
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
  $unpath = "${Env:ProgramFiles(x86)}\InstallShield Installation Information\{88547073-C566-4895-9005-EBE98EA3F7C7}\setup.exe"
  } else {
  $unpath = "${Env:ProgramFiles}\InstallShield Installation Information\{88547073-C566-4895-9005-EBE98EA3F7C7}\setup.exe"
}
Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
