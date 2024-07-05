$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$softwareName = "$packageName"
$installerType = 'exe'
$silentArgs = '/S /v/qn'
$validExitCodes = @(0,3010)

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

$key | ForEach-Object {
  Uninstall-ChocolateyPackage -PackageName $packageName `
                              -FileType $installerType `
                              -SilentArgs "$($_.PSChildName) $silentArgs" `
                              -ValidExitCodes $validExitCodes
}
