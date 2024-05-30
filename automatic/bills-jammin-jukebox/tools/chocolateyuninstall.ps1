$packageName = 'bills-jammin-jukebox'
$installerType = 'EXE' 
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$processor = Get-WmiObject Win32_Processor

$is64bit = $processor.AddressWidth -eq 64
if ($is64bit) {
$unpath = "${Env:ProgramFiles(x86)}\Bill's Jammin Jukebox\unins000.exe"
  } else {
$unpath = "${Env:ProgramFiles}\Bill's Jammin Jukebox\unins000.exe"
  }

Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $unpath -validExitCodes $validExitCodes
