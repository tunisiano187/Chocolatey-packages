$ErrorActionPreference = 'Stop'
$packageName    = 'drivermax'
$softwareName   = 'DriverMax*'
$installerType  = 'EXE'
$silentArgs     = '/VERYSILENT'
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$bits           = Get-ProcessorBits

if ($bits -eq 64)
  {
   $unpath = "${Env:ProgramFiles(x86)}\Innovative Solutions\DriverMax\unins000.exe"
  } else {
   $unpath = "${Env:ProgramFiles}\Innovative Solutions\DriverMax\unins000.exe"
  }

Start-CheckandStop "drivermax"

Uninstall-ChocolateyPackage $packageName $installerType `
  $silentArgs $unpath -validExitCodes $validExitCodes
