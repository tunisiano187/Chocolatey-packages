# openSUSE-42 doesn't support being silently installed. This script kludges it.
$ErrorActionPreference = 'Stop'
$packageName    = 'wsl-opensuse'
$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url            = 'https://aka.ms/wsl-opensuse-42'
$checksum       = '7E8D474A53631C4843C7F209E3530B777A40F6DA12B9C91AEA418071D76DCA02'
$unzipLocation  = "$toolsDir\wslfiles"

# When Chocolatey moves the package files in the lib directory to lib-bkp upon upgrade it will cause a 
# disconnection between WSL and the registered location of the WSL distribution files. 
# It was considered to unregister the distribution and reinstall, but anything created, installed, or upgraded 
# in the current distribution's filesystem would be lost. Decided: Best to abort. 
if (Test-Path $env:ChocolateyInstall\lib-bkp\$packageName){
   Write-Warning "  * Upgrades are not supported. Please uninstall and reinstall the package."
   Write-Warning "  * Consider pinning this package to avoid attempted package updates and preserve your configuration:"
   Write-Warning "  * ""choco pin add -n=$packageName"""
   throw
  } 

$packageArgs = @{
  packageName    = $packageName
  unzipLocation  = $unzipLocation
  fileType       = 'ZIP' 
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

# open openSUSE-42 installer in a new window
Set-Location -Path $unzipLocation
Start-Process openSUSE-42.exe

Write-Host "  **********************************************************************************" -foreground magenta
Write-Host "  * When you see ""Installation successful!"" in the other window, you may close it. *" -foreground magenta
Write-Host "  * Otherwise, just wait up to 25 seconds and it will close automatically.         *" -foreground magenta
Write-Host "  * Unsuccessful installs will abort and close automatically after 15 minutes.     *" -foreground magenta
Write-Host "  **********************************************************************************" -foreground magenta

# Make sure openSUSE-42 starts setting up and doesn't give an error
Start-Sleep -Seconds 5
if (Test-Path $unzipLocation\rootfs)
   {
# wait for openSUSE-42 installer to finish extracting files
    $LoopMePlease=0
    while (!(Test-Path $unzipLocation\rootfs\var\tmp)){
           Start-Sleep -Seconds 15
		   $LoopMePlease++
# break out of the loop after 15 minutes in case of error
		   if ($LoopMePlease -gt 60) { 
			  $SomethingWentWrong=$true
	          Write-Warning "Something went wrong. Possibly openSUSE-42 already installed or corrupt."
			  wslconfig /list
		      break
			 } 
          }
    } else {
	  Write-Warning "Something went wrong. Possibly you haven't rebooted since enabling WSL."
	  $SomethingWentWrong=$true
	 }

# wait 10 more seconds to make sure the files IN rootfs\var\tmp get extracted
if (!($SomethingWentWrong)) {Start-Sleep -Seconds 10}

# terminate openSUSE-42.EXE ~when it hits the "Enter new UNIX username:" prompt (meaning installation has finished)
Start-CheckandStop "openSUSE-42"
Start-CheckandStop "wsl"

if ($SomethingWentWrong) {throw}

# The normal prompting for creation of a default user and password is bypassed (aborted) by this script,
# necessitated for automated install.
Write-Host "  ** root is the default user upon running WSL/openSUSE-42." -foreground magenta
wslconfig /list
