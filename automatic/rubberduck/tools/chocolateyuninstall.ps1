$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'rubberduck'
$registryUninstallerKeyName = '{979AFF96-DD9E-4FC2-802D-9E0C36A60D09}_is1' #ensure this is the value in the registry
$shouldUninstall = $true

$local_key       = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$local_key6432   = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key     = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

$file = @($local_key, $local_key6432, $machine_key, $machine_key6432) `
    | Where-Object{ Test-Path $_ } `
    | Get-ItemProperty `
    | Select-Object -ExpandProperty UninstallString

if ($null -eq $file -or $file -eq '') {
    Write-Output "$packageName may have been uninstalled by other means."
    $shouldUninstall = $false
}

$installerType = 'EXE'
$silentArgs = '/SILENT'
$validExitCodes = @(0)

if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}
