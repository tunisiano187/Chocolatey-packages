$ErrorActionPreference = 'Stop'
$packageName = 'logitech-media-server'
$bits = Get-ProcessorBits

if ($bits -eq 64){
    $unpath = "${Env:ProgramFiles(x86)}\Squeezebox\unins000.exe"
   } else {
    $unpath = "${Env:ProgramFiles}\Squeezebox\unins000.exe"
   }

$packageArgs = @{
  packageName    = $packageName
  filetype       = 'EXE' 
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-' 
  validExitCodes = @(0) 
  file           = $unpath
}  

Uninstall-ChocolateyPackage @packageArgs
