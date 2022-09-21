$packageName = 'arduino'
$softwareName = 'Arduino*'
$installerType = 'exe'
$silentArgs = '/S'
$validExitCodes = @(0)

[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName
Write-Warning "Warning: All existing files in `"$(Split-Path $($key.UninstallString))`" will be deleted. This includes files and folders present before or added since you installed the Arduino software."
Write-Warning "Ctrl+C to cancel.  Continuing in 5 seconds..."
Start-Sleep -Seconds 5

$key | ForEach-Object {
  Uninstall-ChocolateyPackage -PackageName $packageName `
                              -FileType $installerType `
                              -SilentArgs $($silentArgs) `
                              -File $($_.UninstallString.Replace('"','')) `
                              -ValidExitCodes $validExitCodes
}

Remove-Item "$ahkRun" -Force