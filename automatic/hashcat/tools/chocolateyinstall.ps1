$folderName = "hashcat-4.1.0"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$source     = Join-Path "$toolsDir" "$folderName"
$installDir = "$(Get-ToolsLocation)"

Copy-Item -Path "$source" -Destination "$installDir" -Recurse -Force

$psfile     = Join-Path "$toolsDir" "hashcat.ps1"
Install-ChocolateyPowershellCommand -PackageName "hashcat" -PSFileFullPath "$psfile"