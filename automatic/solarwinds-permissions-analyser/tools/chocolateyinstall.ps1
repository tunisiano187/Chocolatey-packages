$ErrorActionPreference = 'Stop';
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url            = ''
$checksum       = ''
$checksumType   = ''

Install-ChocolateyZipPackage -PackageName $env:ChocolateyPackageName -Url $url -UnzipLocation "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" -checksum $checksum -checksumType $checksumType

 $file          = Join-Path $(Get-Location) "SolarWindsPermissionsAnalyzerTool.msi"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $file

  softwareName  = 'Solarwinds-Permissions-Analyser*'

  checksum      = $checksum
  checksumType  = $checksumType

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
Test-Package