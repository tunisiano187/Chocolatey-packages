$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$fileType = 'exe'
$silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)
$osBitness = Get-ProcessorBits
if ($osBitness -eq 64) {
  $unPath = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
} else {
  $unPath = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
}
$unString = (Get-ItemProperty $unPath\* | Select-Object DisplayName, UninstallString | Where-Object {$_.DisplayName -like "$packageName*"}).UninstallString
Uninstall-ChocolateyPackage "$packageName" "$fileType" "$silentArgs" "$unString" -validExitCodes $validExitCodes
