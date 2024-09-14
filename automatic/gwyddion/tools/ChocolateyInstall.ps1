$ErrorActionPreference = 'Stop'
$packageName = 'gwyddion'
$bits        = Get-ProcessorBits
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file        = Get-Item $toolsDir\Gwyddion*.exe

if ($bits -eq 64){
	$installer=$(Get-Item $toolsDir\Gwyddion-*win64.exe).name
} else {
	$installer=$(Get-Item $toolsDir\Gwyddion-*win32.exe).name
}

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'EXE'
  file           = "$toolsDir\$installer"
  validExitCodes = @(0)
  silentArgs     = '/S'
  softwareName   = 'Gwyddion'
}

Install-ChocolateyInstallPackage @packageArgs 	

Remove-Item $toolsDir\*.exe -EA SilentlyContinue | Out-Null

# UPDATE INSTRUCTIONS
# Replace EXE files
