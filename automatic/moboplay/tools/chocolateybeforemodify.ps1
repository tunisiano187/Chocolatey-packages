$packageName = 'moboplay'

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