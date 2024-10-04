$ErrorActionPreference = 'Stop'
$packageName = 'log4jscanwin' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$bits        = Get-ProcessorBits

Get-ChocolateyUnzip -FileFullPath "$toolsDir\Log4jScanner.zip" -Destination $toolsDir
if ($bits -eq 64){New-Item "$toolsDir\Log4jScanner\x86\Log4jScanner.exe.ignore" -type file -force | Out-Null}
if ($bits -eq 32){New-Item "$toolsDir\Log4jScanner\x64\Log4jScanner.exe.ignore" -type file -force | Out-Null}
Remove-Item "$toolsDir\*.zip" -EA SilentlyContinue | Out-Null
