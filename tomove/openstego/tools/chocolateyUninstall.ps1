# powershell v2 compatibility
$psVer = $PSVersionTable.PSVersion.Major
if ($psver -ge 3) {
  function Get-ChildItemDir {Get-ChildItem -Directory $args}
} else {
  function Get-ChildItemDir {Get-ChildItem $args}
}
$warningPreference = "Continue"
$chocoLib = Join-Path $env:ChocolateyInstall "lib"
if (Test-Path -PathType Container (Join-Path $chocoLib 'openstego.*')) {
  Write-Warning "Uninstall NOT complete."
  Write-Output
@"
  This package is a metapackage; a chocolatey feature not yet fully implemented.
  To retain future compatibility this package does not uninstall the dependent
  package it points to as designated with *.install or *.portable.`n
"@
  Write-Warning "To finish removing the program installed by package openstego, please also run the command:"
  Write-Output " `n`tchoco uninstall " -NoNewLine
  $list = (Get-ChildItemDir $chocoLib\openstego.*).Name
  foreach ($i in $list) {
    Write-Output "$i " -NoNewLine
  }
  Write-Output "-y"
}
