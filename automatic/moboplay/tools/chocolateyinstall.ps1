$ErrorActionPreference = 'Stop'
$packageName    = 'moboplay'
$installerType  = 'exe'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'http://download.moboplay.com/packages/MobileAssistant/moboplay/pcexe/officialsite/MoboPlay_3.0.6.355.exe' 
$checksum       = '03D515679036A9DD967F81FE9833C62E99C3C6256161CAD88FB8F62EFE82C0B6'
$silentArgs     = '/SILENT'
$validExitCodes = @(0,1)

$packageArgs = @{
  packageName   = $packageName
  fileType      = $installerType
  url           = $url
  validExitCodes= $validExitCodes
  silentArgs    = $silentArgs
  softwareName  = 'MoboPlay*'
  checksum      = $checksum 
  checksumType  = 'sha256' 
}

Install-ChocolateyPackage @packageArgs  
  
Start-Sleep -s 10
  
if((get-process "iMoboPlay" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "MoboPlay for iOS not running. (Good!)" -foreground magenta
  }else{ 
    Write-Host "Stopping MoboPlay for iOS..." -foreground magenta
    Stop-Process -processname "iMoboPlay"
	}
	
if((get-process "aMoboPlay" -ea SilentlyContinue) -eq $Null){ 
    Write-Host "MoboPlay for Android not running. (Good!)" -foreground magenta
  }else{ 
    Write-Host "Stopping MoboPlay for Android..." -foreground magenta
    Stop-Process -processname "aMoboPlay"
	}	