$ErrorActionPreference = 'Stop';

$PreProcesses = Get-Process
function Delta-Process {
  Param(
        [Parameter(ValueFromPipeline = $true)]
        [System.Diagnostics.Process[]]
        $BaseProcesses
  )
  $PostProcesses = Get-Process
  $NewProcesses = @()

  $PostProcesses | ForEach-Object {
    $PostProcess = $_
    $PossiblyNew = $true

    $BaseProcesses | ForEach-Object {
      if( ($PostProcess.Id -eq $_.Id) -and ($PostProcess.Name -eq $_.Name) ){
        $PossiblyNew = $false
      }
    }

    if( $PossiblyNew ){
      $NewProcesses += $PostProcess
    }
  }

  return $NewProcesses
}

$packageName = '010editor'
$softwareName = '010 Editor*'
$installerType = 'EXE'

$validExitCodes = @(0, 3010, 1605, 1614, 1641)
if ($installerType -ne 'MSI') {
  $silentArgs = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  $validExitCodes = @(0)
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($key.Count -eq 1) {
  $key | ForEach-Object {
    $file = "$($_.UninstallString)"

    if ($installerType -eq 'MSI') {
      $silentArgs = "$($_.PSChildName) $silentArgs"

      $file = ''
    }

    Uninstall-ChocolateyPackage -PackageName $packageName `
                                -FileType $installerType `
                                -SilentArgs "$silentArgs" `
                                -ValidExitCodes $validExitCodes `
                                -File "$file"
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$key.Count matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $_.DisplayName"}
}

(Delta-Process $PreProcesses) | ForEach-Object {
  if( $_.Path.Contains( $env:TEMP ) ){
    Stop-Process -Id $_.Id -Force
  }
}
